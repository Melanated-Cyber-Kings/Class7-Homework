
# Configuring EC2 instance in AWS:
# To create an Amazon Elastic Compute Cloud (EC2) instance, you will use the AWS Management Console to configure your virtual server's operating system, hardware, storage, and network access. This guide covers the process for a standard setup. 

# Prerequisites
        1. An active AWS account.   
        2. An understanding of the AWS Free Tier limitations to avoid unexpected charges. 

# Step 1: Sign in and launch the instance
        1. Navigate to the AWS Management Console and sign in.
        2. Search for and open the EC2 service.
        3. In the EC2 Dashboard, click the Launch Instance button. 
# Step 2: Configure instance details
        1. Name and Tags: Enter a descriptive name for your instance, such as MyFirstWebServer. You can also add tags to help organize and identify your resources.
        2. Application and OS Images (AMI): An Amazon Machine Image (AMI) is a template for your server's software. For your first instance, choose a "Free tier eligible" option like Amazon Linux or Ubuntu from the Quick Start list.
        3. Instance Type: This defines the hardware of your virtual server. To stay within the Free Tier, select the t2.micro instance type.
        4. Key Pair (Login): A key pair is required for secure access to your instance.
            a.Click Create new key pair.
            b.Enter a name (e.g., my-ec2-key).
            c. Choose the file format you need. Select .pem if you are connecting from Linux or macOS.
            d. Click Create key pair and save the downloaded file in a secure location. If you lose this file, you will lose access to your instance. 
# Step 3: Configure network and storage settings
        1. Network Settings: Accept the default VPC and subnet. Configure Firewall (Security Groups) to include SSH (port 22) access, ideally limited to "My IP". Ensure "Auto-assign 
        2. Public IP" is enabled.
        3. Configure Storage: The default storage is usually sufficient. The Free Tier includes up to 30 GB of General Purpose SSD storage. 
# Step 4: Add your user data script.
        1. Scroll down to the Advanced details section.
        2. Expand the section and find the User data text box.
        3. Paste your script into the box. The script must begin with a shebang line, such as #!/bin/bash for a Linux shell script.
# Step 5: Launch and connect to your instance
        1. Review: Check your configuration in the summary panel.
        2. Launch: Click Launch instance and wait for the confirmation.
        3. Monitor: On the EC2 Instances page, watch the instance state change from "pending" to "running".
        4. Connect: Select your running instance, click Connect, and follow the instructions for EC2 Instance Connect for easy browser-based SSH access. 
# Step 6: Teardown / Clean up (terminate your instance)
        1. To avoid charges, terminate your instance when no longer needed. 
        2. On the EC2 Instances page, select your instance.
        3. From the Instance state dropdown, choose Terminate instance.
        4. Confirm the action. 
* This provides a basic guide for creating a Free Tier-eligible EC2 instance. More complex needs may require customization.
