# Mattermost Active-Directory Import

## This Powershell script gets all AD Users based on the given OU/CN and converts them into a JSON file that can be used for the Mattermost bulk import tool: https://docs.mattermost.com/deployment/bulk-loading.html It allows to add the team and channels that the new user should be part of when logging in the first time.

Just call the script (I used a sample Windows 2012 R2 domain controller). Please note that the script name is: import.ps1.

mattermost-ad_import/images/0_call_import.png
