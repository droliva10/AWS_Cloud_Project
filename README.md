# AWS_Cloud_Sandbox_Project
## Section One
Launching an AWS Instance. 
Make sure you are aware of what region you are in, select the region that is closest to you.  
In the below instrunction you will “Launch an AWS instance”.

1. In Name and tags field: Name Instance.
   
![Capture40](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/9874d7d3-a946-4f7c-bbce-c9b59f2018a9)

3. In Applications and OS Images (Amazon Machine Images): Select Microsoft Windows Server 2022 base.
   
![Capture41](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/f6ca581b-7f5f-4434-a5af-023a3490b0b1)

5. In Instance type: Select t2.medium.
   
![Capture42](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/02befa26-04e0-4282-b984-4d3290038c30)

7. In Key pair(login): Click "Create key pair", name key pair and keep default settings.
   
![Capture43](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/edac3c98-7b0d-46b9-a9e9-e7ddac2b0df7)

9. In Network settings: Use default settings and make sure RDP is selected.
    
![Capture44](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/c39d0045-ebb5-4f01-aab5-5c0c6c3a786b)

11. In Configure Storage: Change GiB to "60"
    
![Capture45](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/fc5db9e8-a79a-41c2-865a-600b3b1ea1e7)

13. Click "Launch Instance" to launch instance.
    
![Capture46](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/f7170a93-f552-4c3b-9d18-a8efef5ada5b)

## Section Two
Connect to instance via RDP.

1. After launching instance, click “View all Instances” at the bottom of the page.
   
![Capture47](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/25b25903-700d-4cd0-8910-75084c689c1f)

3. Click the box for the new instance you want to connect to and click "Connect".
   
![Capture48](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/0a7ebcac-51c7-44cb-b8fa-d5d208a731a6)

4. Click the RDP client tab. If you are using Windows, download remote desktop file and move on to step 5. For macOS users decrypt password per step 5, check out step 6 for more instructions.

Username:
```
Administrator
```

![Capture49](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/c696983c-b267-430d-bf4d-f5e5259564ba)

5. Click "Get password" this password will be used to RDP into instance. Click "Upload private key file", this is
was created you created a rsa key pair. Once uploaded click "decrypt password". Copy decyrpted password. Paste
password in document and save file.

![Capture50](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/23e389e6-a93f-4457-86fe-c4f71d871fbb)

6. In the download folder, double click remote descktop file to open a RDP executible file. When prompted paste Administrator
password to authenticate the RDP sesssion. For macOS users, download macOS client.

[Check out this link for instruction to user and download Microsoft Remote Desktop] (https://learn.microsoft.com/en-us/windows-server/remote/remote-desktop-services/clients/remote-desktop-mac)

## Section Three
Configure the Windows Server with FlareVM.
After FlareVM and dependencies/packages are installed, an AMI will be created following the installation.
Install both Chrome and Firefox browsers. If there is any particular malware analysis tools you are requiring
for your sandbox environment, now would be a good time to install. If you setup and run INeTSim you will be isolated from
the internet.

1. While in the the newly create instance, open a browser of your choice and download the raw file. This is the
Mandiant flare-VM script that will be the bases of you sandbox enviornment.

[Go to URL:] (https://github.com/mandiant/flare-vm/blob/main/install.ps1)

![Cature](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/52d992a5-1a8d-4f20-82b2-c3420faa047d)

2. Open powershell and move to the Downloads directory.

Run Commands:
```
Unlock-File ./
Unlock-File ./install.ps1
Set-ExecutionPolicy Unrestricted
```
At the prompt type "yes" and hit enter. Now minimize powershell.

3. Disable Microsoft Defender:
Navigate to Proxy settings and turn off "Automatically detect settings".
Navigate to Local Group Policy Editor, typing "group" in the search bar to query.
Once in the Local Group Policy Editor, navigate to Window Defender Antivirus.
Computer Configuration>Administrative Templates>Windows Components>Microsoft Defender Antivirus
Open "Turn off Microsoft Defender Antivirus" and click enable, then apply and save.

Now navigate to Domain Profile.
Computer Configuration>Administrative Templates>Network>Network Connections>Windows Defender Firewall>Domain Profile
Open Window Defender Firewall: Protect all network connections: click disable, then apply and save.

![Capture3](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/f8559041-930c-4e7a-987a-3da80ce45d46)

Now navigate to Standard Profile.
Computer Configuration>Administrative Templates>Network>Network Connections>Windows Defender Firewall>Standard Profile
Open Window Defender Firewall: Protect all network connections: click disable, then apply and save.

![Capture5](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/9f317b2d-d442-46be-a816-62a66a065e3f)

4. Now click powershell on the bottom bar, which you minimized in step 2.

Run Command:
```
./install.ps1
```

There will be multiple checks enter Yes "Y" and hit enter. When you get to Administrator password, enter the 
the decrypted password user used to first sign into the server. A dialog box will open after the script runs,
with default packages selected. You can add or remove packages here, in most case default is probably fine. When done
click "OK" to begin installation. The system will reboot multiple times, relogin after disconnection.

5. After flarevm installation, open failed packages folder, and verify all the important packages were successfully installed.

 ## Section Four
Creating a AMI

1. Return to the AWS console and stop the instance.
While instance is stil selected, click Actions drop down then select Images and templates, and click "Create image".

![Capture7](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/04c2cba2-c770-4716-90e7-e8be4141f667)

2. Name the image, keep default setting and click "Create image"

![Screenshot 2023-08-31 224351](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/b2249ce2-68d6-4f2b-9ca3-f4c039e746d5)

## Section Five
Create user.

1. Duplicate tab and navigate to AWS IAM.

![Screenshot 2023-08-31 224919](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/1e716f43-3639-4000-af74-fa4124a6c223)

2. Go to Users and click "Create users".
Name it and click "Next"

![Capture51](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/9023e3b3-0842-4c1d-8951-9dbae355637f)

3. Click "Create group" to create user group.
Name user group, "XXX-Full-Access" and search "ec2f" in the search bar under permissions policies. Check mark the box,
then click "Create user group".

![Capture52](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/2c8ff629-0325-4d00-87c3-157681b253a0)

4. Next check mark the Group name in User groups, and click "Next"

![Screenshot 2023-08-31 230243](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/fe0c4be4-95d1-4444-ac20-8d910d2505b1)

6. Now click "Create user" to finalize.

![Screenshot 2023-08-31 230416](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/5a7f4d30-b154-4627-a440-51ddcd216670)

## Section Six
Create access key.
Stay in IAM>Users

1. Click the new user name.

![Screenshot 2023-08-31 230613](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/ee2dd7fc-87ff-4d93-ade1-5c6996d97783)

2. Click "Security credentials" tab and scroll down to Access keys field.

![Capture57](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/164b2af5-390c-41e5-9593-1b5393955ff3)

3. Click "Create access key".

![Capture58](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/e151315b-49dc-4875-a5cb-8cf4ff9afff1)

4. Select "Command Line Interface (CLI) and select confirmation check box at the bottom, then click "Next"

![Screenshot 2023-08-31 231559](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/ada66073-1f9f-4d54-9477-2b1e208c0eab)

5. Enter destription from Description tag value.
Name is "XXX-Access-Key" and click "Create access key"

![Capture61](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/dd6f5782-4655-4dba-8023-f7e4589c7765)

6. Retrive access key and secret key, copy them and paste in a document and click "Done".
This will be the only time you will be able to copy both keys.

![Capture8](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/aba40879-3d3b-4d3a-84b0-d9939a1f5d64)

## Section Seven
Setting remote acces to AWS.
Multiple packages will need to be installed, "jq, AWS-CLI, and Terraform" on to your local machine.
Homebrew may need to be installed on macOS, if homebrew package manager is not already installed.

Run Command:
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

1. Install jq, awscli, and Terraform.

Run Commands:
```
brew install jq
brew install awscli
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
brew update
brew upgrade hashicorp/tap/terraform
```
Test awscli by running “awscli” on the command line.
Test terraform by running “terraform -help” on the command line.

## Section Eight
Setup working directory.

1. Make a working directory.

Run Command:
```
mkdir malware-cloud-lab
```
2. Change to new directory.

Run Command:
```
cd malware-cloud-lab
```
![Capture9](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/2260e0be-518c-4b3f-a799-a55ec13a3353)

3. Run AWS-CLI to setup remote access.

Run Command:
```
aws configure
```
At the prompt	enter AWS Access key and hit enter. 
At the prompt enter Secret Key and hit enter. 
Next enter the region the AWS instance and hit enter 
Then type “json” and hit enter.

![Capture63](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/7e936d71-c3e9-4149-88f5-cbcc84c740b6)

## Section Nine
Pull AWS-malware-lab clone.

1. Clone a AWS malware lab from GitHub.

Run command:
```
git clone https://github.com/adanalvarez/AWS-malware-lab
```

## Section Ten
Edit files in the AWS-malware-lab directory.

1. Move into the AWS-malware-lab directory.

Run Command:
```
cd AWS-malware-lab
```

2. Make a file and name it “shared.auto.tfvars.json”.

Run Command:
```
touch share.auto.tfvars.jason
```
3. Add the below block. The "ami" is ami of the flare-vm which was created in Section Four. The "account" is the AWS account.
The "region" is the region the flare-VM the was created in. For a sandbox with only internet access, leave "enable_guacamole"
and "enable_inetsim" false. If you want to isolate instance during malware detonations, make INeTSim true.


```
{
     "environment": "malware-lab", 
     "ami": "ami-xxxxxxxxxxxxxxxxxx", 
     "account": "11111111111111", 
     "region": "us-west-1", 
     "enable_guacamole": false, 
     "enable_inetsim": false 
}
```

![Capture11](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/a140fe31-b28e-4297-86d7-10697d8158eb)
![Capture20](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/fbaee5e8-e68a-4bf3-b934-32eea9a77655)

## Section Eleven
Edit AWS-malware-lab files.

1. Go to AWS console and navigate to the AMI catalog. In the search bar search for "unbuntu". Copy the ami string.

![Capture13](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/334776cb-a34c-4354-a264-e18ec1e02d73)

2. Return to your local machine command line.

Run Command:
```
terraform –version
```

This will outout the terraform version.

![Capture35](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/4d9024fc-13b1-46f5-aa0f-280e4c91b6eb)

3. Open main.tf with a text editor. On the second line, edit terraform verion with the version output. Save exit editor.

![Capture37](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/01e0d7df-6af2-4765-8315-823bb6972e3b)

4. Open instance.tf with a editor.
Scroll down to “Linux instance with INeTSim” Edit the ami with the ami string you copied from step 1 of this section.

![Capture38](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/3d0871fc-7d6f-48f0-bcc6-768051ee613c)

## Section Twelve
Build the AWS infrastructure.
You should not get any errors in any of the below steps, troubleshoot if you get errors.

1. Initialize terraform.

Run Command:
```
terraform init
```
2. Create the execution plan.

Run Command:
```
terraform plan
```

3. Executes the actions.

Run Command:
```
terraform apply
```

4. At the prompt type “yes”.
The AWS infrastructure will begin building. At the completion of the build copy the output IP.

![Capture32](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/74b48f06-fc3b-47b1-9fff-23a1f278e897)

## Section Thirteen
Connect to malware lab/sandbox environment.

1. Open RDP client enter copied IP. For macOS users open Microsoft Remote Desktop and add a new PC.
Username = Administrator 
Password = User password you decrypted in section two.

## Section Fourteen
To run in an isolated environment, no internet access. Test INETSim server, if set to true in Section Ten step 3.

1. Open powershell

Run Command:
```
Get-NetAdapter -Name "Ethernet 2" | Set-DnsClientServerAddress -ServerAddresses 	"172.16.10.6"
```
2. Test internet.
Open a browser and do a google search you should see a INeTSim warning. Traffic is now route through fake DNS server. If INetSim is not configured open internet will be acheived.

## Section Fifteen
To shut down sandbox environment and delete AWS Infrastructure.

1. To destroy environment.

Run Command:
```
terraform destroy
```

2. Enter “yes’ when prompted.

![Capture34](https://github.com/droliva10/AWS_Cloud_Project/assets/76188926/e1c11b01-5b72-4a7c-8b21-403dbcc1d6f2)

## COST
AWS On-demand Windows base: 0.0732 USD per Hour
AWS On-demand Linux base: 0.0276 USD per Hour
