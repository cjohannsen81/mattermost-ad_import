# Mattermost Active-Directory Import

#### This Powershell script gets all AD Users based on the given AD group and converts them into a JSON file that can be used for the Mattermost bulk import tool: https://docs.mattermost.com/deployment/bulk-loading.html

#### It allows to add the team and channels for the users. They will be part of these channels when logging in the first time.

Please note that the Enterprise Edition is needed.

1. Just call the script (I used a sample Windows 2012 R2 domain controller). Please note that the script name is: import.ps1.

![alt text](https://github.com/cjohannsen81/mattermost-ad_import/blob/master/images/0_call_import.png)

2. The result is an import JSON file that matches the specifications of the bulk import tool.

![alt text](https://github.com/cjohannsen81/mattermost-ad_import/blob/master/images/1_import_json.png)

3. After you copied the JSON file to the Mattermost server, validate the import using the bulk import tool (/opt/mattermost/bin/): sudo ./platform import bulk /tmp/import.json --validate

 ![alt text](https://github.com/cjohannsen81/mattermost-ad_import/blob/master/images/2_validate_import_json.png)

4. With switching the attribute from --validate to --apply the file import begins.

![alt text](https://github.com/cjohannsen81/mattermost-ad_import/blob/master/images/3_apply_import_json.png)

5. You can check the imported user in the System Console of your Mattermost Server.

![alt text](https://github.com/cjohannsen81/mattermost-ad_import/blob/master/images/4_imported_users.png)

6. Now you can try a login with one of the AD users to check the channel association.

![alt text](https://github.com/cjohannsen81/mattermost-ad_import/blob/master/images/5_import_user_login.png)

7. Finally you should be able to see the associated channels for this user (testchannel and secondone in my demo)

![alt text](https://github.com/cjohannsen81/mattermost-ad_import/blob/master/images/6_user_channels.png)


#### In case you want to change of enhance the script, feel free to create a pull request.

Author: Christian Johannsen
Twitter: cjohannsen81
