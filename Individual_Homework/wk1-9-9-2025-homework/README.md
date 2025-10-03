# wk1-9-9-2025-homework

Includes Screen Shots of Modified Stock Setup.

Step By Step Instructions As Follows:

how to setup a ec2 instance


1) login into aws and search for security groups at the top
create a security group.
give it a name and description (which can be anything you want, can be the same)
for inbound rules, set type to http and source to anywhere-ipv4
do not touch outbound rules.
hit create security group to save.

2) now search for ec2 at the top and hit launch instance
give it a name (can be anything you want)
scroll down to key pair name and click create new key pair
give the key pair a name (anything you want) and hit create key pair.  it will download a pem file to your machine.
on Network Settings, hit select existing security group and change it to the one created earlier.
on Advanced Details, scroll all the way to the bottom and copy and paste the raw text from https://github.com/MookieWAF/bmc4/blob/main/ec2scrpit into the User Data Field.
Then hit Launch Instance

3) now search for instances and the top again (specifically for ec2)
click on the instance id that you just created.
copy the public dns name of the instance, paste into the browser, put http:// in front (not https://) in the browser, and hit enter.
You should see server details if it works.

4) on the same page, hit instance state -> terminate (delete) instance, then hit terminate(delete) 

