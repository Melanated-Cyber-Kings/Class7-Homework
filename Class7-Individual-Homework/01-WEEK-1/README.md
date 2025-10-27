# Images (screenshots)

Samurai Katana screenshot

[<img src="./images/samurai-katana-screenshot.png" alt="Samurai katana" width=""/>](./images/samurai-katana-screenshot.png)

# EC2 Set-up and Tear-down Instructions

Launch EC2 Instance Instructions

Build an EC2/Instance on AWS
Click on the orange EC2 or search from the Home page
Click on Network Security Groups on the left-hand side of the screen
Create a security group (SEC-GRP) by clicking the orange button in the upper right-hand corner of the screen
For Basic Details: SEC-GRP -> Name: Enter SEC-GRP name (one-word, no spaces)
Description: Paste SEC-GRP name
Inbound Rules: Select ‘Add Rule’ => Select: ‘HTTP’ => Source: Select ‘IPv4’
Description (Optional): Paste SEC-GRP name
Outbound Rules: DO NOT TOUCH
Under the Tags section: Key: Type ‘Name’ => For Value: Paste SEC-GRP name
Create SEC-GRP, by clicking the orange button
Click ‘Instances’ on the left-hand side of the page => Launch Instance by clicking the orange button
On the Names & Tags section: Paste SEC-GRP name
For Key-Pair login: Click ‘Proceed without key-pair’.
Network Settings: Firewall SEC-GRP => Select ‘Existing SEC-GRP’
Common SEC-GRPS: Paste SEC-GRP name
Click ‘Advanced Details’ => scroll down to the bottom of the page, marked ‘User Data’
Copy the start-up script from Theo’s GitHub account => Press ‘copy’ => paste the data into the “User Data’ section of the EC2 screen
https://github.com/MookieWAF/bmc4/blob/main/ec2scrpit
Launch Instance, by clicking the orange button
A green bar across the top of the page stating: ‘Successfully Launched Instance’
Click on the Instance number (ex, i-0b26a937642da6218)
Click the ‘copy’ button of ‘Public DNS’ on the right-hand side of the screen
Open a new tab, enter: HTTP://’ and ‘paste’ the Public DNS information

Tear-down of EC2

Click on ‘Instance’ on the left-hand side of the homepage
Click on ‘Instance State’ => ‘Terminate (Delete) Instance’ 

**Go to Submissions Log**

[Submissions Log](./Class7-Individual-Homework/README.md)