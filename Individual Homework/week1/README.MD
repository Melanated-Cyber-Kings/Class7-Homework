# Amazon Web Service (AWS) EC2 Deployment

Deploy a basic EC2 instance in an AWS region.

1. Access AWS console via web browser application.

2. Set AWS region to us-east-2. Move to the EC2 dashboard.

![EC2 Dashboard](/Individual%20Homework/week1/graphics/aws-ec2-dashboard.png)

3. There should be a default Virtual Private Cloud. You can use the default or create a new VPC. A good practice is to create a new VPC for projects and leave the default VPC alone.

4. Create a Security Group (SG) with only a HTTP inbound rule.

- Under Network & Security > Security Groups
    - Select Create Security Group

    - Input a Name and Description for the SG

    - Verify the VPC is the default that the SG

    - In Inbound Rules add a rule of 
        - Type: HTTP
        - Protocol: TCP
        - Port Range: 80
        - Source: anywhere-IPV4 # Note this not a best practice. 
        - Description 

    - Outbound Rules will *NOT* be modified. Leave this setting as-is.

    - Tags: Add tags to support being able to find or have an idea what or when this was created. 

    ![SecurityGroup](/Individual%20Homework/week1/graphics/aws-security-group-01.png)
  

    - Select Create Security Group 
    - Verify the newly created SG has the settings you require.

    ![Completed SG](/Individual%20Homework/week1/graphics/completed-security-group.png)

5. Obtain a startup script for your EC2 instance.

    - Create or use a provided startup script that will be used by the EC2 instance when it is initially deployed in the AWS VPC.

    - For this instance it is a file named ec2script.txt. Under normal operations it would have a filename extension as ".sh". In this deployment we leave it as a text file. 

6. EC2 Deployment

    - In the EC2 dashboard menu, select Instances

    - Select Launch Instances

    - Under name and Tags input a name. For example My-HTTP-Server

    - Select Amazon Linux Machine Image (AMI) with AWS logo. You have other types but for this project we will stay with the basic Linux AMI.
    - Note the username for the image. The default user is ec2-user.

    - In Instance Type: select t3.micro. It may be a different Instance Type depending on when you are using this guide. It also may vary depending on what AWS region you are deploying an EC2 instance (e.g. Tokyo, Germany).

    - Create a new key pair. 
        - Name the SSH key pair the name of your EC2 instance.
            - Key pair name: My-HTTP-Server
            - Key pair type: RSA
            - Private key file format: .pem
        - Select Create key pair button.

        ![Create Key pair](/Individual%20Homework/week1/graphics/aws-ec2-create-key-pair.png)


        [NOTE] A PEM file with the name of your key will be downloaded to your management system that you are accessing the AWS EC2 dashboard. Please be sure to store the file in a safe place.

        - Set permission on the downloaded .pem file to 0400. This will set the owner to have Read permission, Groups and users will have no Read, Write or Execute permission to the file. For this type of file you only need Read permission.

    - Network Settings.
        - Leave Network, Subnet and auto-assign public IP in their default configuration.

        - In Firewall (security groups), select existing security group
            - Select the security group you created earlier. In this example we named it SG-01.

        ![network settings](/Individual%20Homework/week1/graphics/aws-ec2-network-settings.png)

    - Configure Storage: Leave this as is.

        ![configure storage default](/Individual%20Homework/week1/graphics/aws-ec2-configure-storage.png)

    - Advanced details.
        [CAUTION] There are a lot of settings here that can be modified. For this project we will *ONLY* leverage the user data feature.

        - In the user data field you will see the option to either choose a file or paste content into the web browser interface. In our project we will just paste the content from the ec2script.txt file into the space.

        - Open the ec2script.txt file and copy and paste the contents into the user data field.

        ![user-data-field](/Individual%20Homework/week1/graphics/aws-ec2-user-data-with-content.png)
    
    - Under the Summary field select Launch Instance. 

        ![EC2 summary](/Individual%20Homework/week1/graphics/aws-ec2-summary.png)

        If all of your settings were correct then you should see a green banner stating that the launch was successful.

        ![Launch successful](/Individual%20Homework/week1/graphics/aws-ec2-launch-successful.png)

    - Select the URL for the EC2 instance in the GREEN success popup in the web browser.

    You will see a lot of information about your EC2 instance including its Public and Private IPv4 addresses. Our objective is to make sure we can access the HTTP service application on the EC2 instance.

    - Select the Public DNS address which should be visible in the Instance summary. This IP address can change if you terminate and/or relaunch the EC2 instance.

    [NOTE] Recall that we are only using the HTTP protocol. So to confirm we have a working service we need to set the browser to use HTTP and *not* HTTPS.

    ![Webpage-example-deployment](/Individual%20Homework/week1/graphics/example-webpage.png)




# Teardown Instructions

In any deployment on AWS we want to make sure we remove all objects we created. This is a good practice especially for proof of concept or demonstration projects like this one.

- Access the EC2 console and terminate any running instances.

- Select each running EC2 instance and select Instance State > Terminate Instances

![AWS Terminate EC2 Example](/Individual%20Homework/week1/graphics/aws-ec2-terminate-instance.png)

- Select the refresh icon to make sure all instances are terminated.

![AWS EC2 terminated](/Individual%20Homework/week1/graphics/aws-ec2-terminated-instances.png)

- Remove the Security Group we created for this demonstration.

- Network & Security > Security Groups
 - Select the security group we named SG-01 or whatever name you chose to use.

 [WARNING] DO NOT TOUCH the *default* security group of the VPC!!!

 ![AWS VPC Custom SG](/Individual%20Homework/week1/graphics/aws-vpc-custom-security-group.png)

- Refresh the window and you should see your original default VPC security group.


Return to your AWS EC2 Dashboard and refresh the web page.

In the Resources you should not see any Running Instances. You may see a number in Instances but those should match the instances you terminated.

As pictured below in the EC2 dashboard I have a quantity of 2 instances. Selecting the Instances shows that those match the last 2 instances that were terminated. You will notice in the screenshot that the dashboard shows no Instances in a *running* state.

![EC2 Dashboard](/Individual%20Homework/week1/graphics/ec2-dashboard-instance.png)


![EC2 Terminated Instances](/Individual%20Homework/week1/graphics/aws-ec2-terminated-instances.png)