# This PowerShell scripts gets all the AD users from a certain searchbase and converts them into a JSON File 
# that is formatted for the Mattermost Bulk Import Tool (Link).

# Set the distinguished name for the users searchbase
$dn = "CN=Users,DC=matter,DC=most,DC=com"

# Get all users from the AD in a specific searchbase
$users = Get-ADUser -Filter * -SearchBase $dn -Properties sAMAccountName,UserPrincipalName 

# Collect the user input for channel and team (ToDo: Add multiple channels/teams)
$teams = Read-Host 'Teams you want to add the users. Please use comma separation if more then one.'
$channels = Read-Host 'Channels you want to add the users. Please use commas separation if more then one.'

# Manadatory attribute
$version = [pscustomobject]@{
    "type" = "version"
    "version" = 1
} 

$version | ConvertTo-Json -Compress | Out-File 'import.json' -Encoding ascii

# Gets all channels and separate them
$channels = $channels.Split(',')

# Get users and convert them into a JSON
foreach ($i in $users)
{
    $userName = $i.sAMAccountName
    if ($userName) 
    { $email = $i.UserPrincipalName
    if ($email) 
    { $user = [pscustomobject]@{
        "type" = "user"
        "user" = [ordered]@{
            "username" = "$userName"
            "email" = "$email"
            "auth_service" = "ldap"
            "auth_data" = "$userName"
            "teams" = @(
                @{            
                    "name" = "$teams"
                    "channels" = @(
                        foreach($i in $channels){
                            @{"name" = $i}
                        }

                    )
                }
            )

        }
    } 
    } else {"$username has no email address."}
} else {"No account name."}
$user | ConvertTo-Json -Depth 5 -Compress | Out-File 'import.json' -Encoding ascii -Append
}