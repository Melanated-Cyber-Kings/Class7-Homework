# 🚀 AWS EC2 Instance Setup & Teardown Guide (ClickOps + Launch Template)

This guide shows how to configure, connect, and tear down an **Amazon EC2 instance** using the **AWS Management Console (ClickOps)**.  
It covers both **manual instance creation** and **Launch Template creation** (with custom User Data script).

---

## 📑 Table of Contents
- [🔑 Prerequisites](#-prerequisites)
- [⚙️ Part 1: Launch a Standalone EC2 Instance](#️-part-1-launch-a-standalone-ec2-instance)
- [📜 Part 2: Create a Launch Template (with User Data Script)](#-part-2-create-a-launch-template-with-user-data-script)
- [🚀 Part 3: Launch an Instance from Template](#-part-3-launch-an-instance-from-template)
- [🔌 Step 4: Connect to Your EC2 Instance](#-step-4-connect-to-your-ec2-instance)
- [🛑 Step 5: Teardown Instructions](#-step-5-teardown-instructions)
- [⚠️ Notes & Best Practices](#️-notes--best-practices)

---

## 🔑 Prerequisites
- An **AWS account** with IAM permissions to create EC2 instances and templates.
- Access to the **AWS Management Console**: [https://console.aws.amazon.com/](https://console.aws.amazon.com/).
- A **Key Pair** (or the ability to create one during setup) to SSH into instances.
- A **startup script** if you plan to use a Launch Template (User Data).

---

## ⚙️ Part 1: Launch a Standalone EC2 Instance

1. Log in to the **AWS Management Console**.
2. In the search bar, type **EC2** and open the **EC2 Dashboard**.
3. Click **Launch Instance**.
4. Configure:
   - **Name**: e.g., `MyFirstEC2`
   - **AMI**: Select OS (Amazon Linux 2, Ubuntu, or Windows).
   - **Instance type**: `t2.micro` (Free Tier eligible).
   - **Key Pair**: Choose existing or create new.
   - **Network settings**:
     - Use default VPC/subnet.
     - Security group rules:  
       - SSH (22) for Linux or RDP (3389) for Windows  
       - HTTP (80)/HTTPS (443) if hosting web content
   - **Storage**: Default (8 GB) or larger if required.
5. Click **Launch Instance**.
6. Verify instance state = **Running** in **EC2 → Instances**.

---

## 📜 Part 2: Create a Launch Template (with User Data Script)

A Launch Template lets you reuse configuration and automatically bootstrap the instance with a script.

1. In the **EC2 Dashboard**, go to **Launch Templates** → **Create launch template**.
2. Fill out:
   - **Template name**: e.g., `MyWebServerTemplate`
   - **AMI**: Select an OS image (Amazon Linux 2 / Ubuntu).
   - **Instance type**: e.g., `t2.micro`.
   - **Key pair**: Select existing or create new.
   - **Security group**: Configure inbound rules (SSH, HTTP, etc.).
   - **Storage**: Default (8 GB) unless more is needed.
3. Expand **Advanced details** → find **User data** field.
4. Paste your script. Example (Amazon Linux 2):

```bash
# Use this for your user data (script from top to bottom)

# install httpd (Linux 2 version)

yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Get the IMDSv2 token

TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Background the curl requests

curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/local-ipv4 &> /tmp/local_ipv4 &
curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/placement/availability-zone &> /tmp/az &
curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/ &> /tmp/macid &
wait

macid=$(cat /tmp/macid)
local_ipv4=$(cat /tmp/local_ipv4)
az=$(cat /tmp/az)
vpc=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/${macid}/vpc-id)

echo "

<!doctype html>
<html lang=\"en\" class=\"h-100\">
<head>
<title>Details for EC2 instance</title>
</head>
<body>
<div>
<h1>AWS Instance Details</h1>
<h1>Samurai Katana</h1>

<br>
# insert an image or GIF
<img src="https://www.w3schools.com/images/w3schools_green.jpg" alt="W3Schools.com">
<br>

<p><b>Instance Name:</b> $(hostname -f) </p>
<p><b>Instance Private Ip Address: </b> ${local_ipv4}</p>
<p><b>Availability Zone: </b> ${az}</p>
<p><b>Virtual Private Cloud (VPC):</b> ${vpc}</p>
</div>
</body>
</html>
" > /var/www/html/index.html

# Clean up the temp files

rm -f /tmp/local_ipv4 /tmp/az /tmp/macid
```

👉 Replace with your own script as needed.

5. Review settings and click **Create launch template**.

---

## 🚀 Part 3: Launch an Instance from Template

1. Go to **EC2 → Launch Templates**.
2. Select your template → **Actions → Launch instance from template**.
3. Choose / Review and adjust details (VPC, subnet, etc.).
4. Click **Launch instance**.
5. Navigate to **Instances → Select your instance** and Verify instance state = **Running in EC2 → Instances**.
6. If your script installed a web server, test by opening the instance’s Public IPv4 address in a browser.

---

## 🔌 Step 4: Connect to Your EC2 Instance

1. Select your instance in the **EC2 Dashboard**.
2. Click **Connect** at the top.
3. Choose one of:
    - **EC2 Instance Connect (browser-based)** (works with Amazon Linux 2/Ubuntu).
    - **SSH client** using your `.pem` key.
    - **Session Manager** (if IAM roles/permissions configured).
4. Once inside, confirm your script/software ran as expected.

---

## 🛑 Step 5: Teardown Instructions

To avoid charges:

1. In **EC2 Dashboard → Instances**, select your instance.
2. Choose **Instance State → Terminate** (permanently deletes VM).
3. Optionally delete associated resources:
    - **Launch Template** (if no longer needed).
    - **Key Pair**.
    - **Security Group**.
    - **Elastic IPs** (if allocated).
    - **EBS Volumes** (if not automatically deleted).

---

## ⚠️ Notes & Best Practices

-   Place reusable software config into the **Launch Template User Data** field for consistency.
-   Use **IAM roles** instead of hardcoding credentials in scripts.
-   Keep **startup scripts idempotent** (safe to rerun multiple times).
-   Always **terminate unused resources** to avoid unexpected billing.

---

✅ You have now successfully launched and managed an EC2 instance using a **Launch Template with User Data** in AWS ClickOps.
```
