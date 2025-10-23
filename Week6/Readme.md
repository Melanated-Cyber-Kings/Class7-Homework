
# Terraform Introduction: WEEK 6 HW ASSIGNMENTS (Terraform pt.1)

## DELIVERABLES (5pts)

- Must be in github repo link provided to your group leader
- Readme.md or <insert_lizzo_here>.txt document of step by step instructions detailing how to set up and initialize Terraform on your computer. 
- Include what programs to use, what programs not to use, what files should or should not be modified, any Github repos to reference, and relevant commands to get the program running.
- Instructions should be detailed enough to provide to someone else so they can use the instructions.
- Screenshot of a successful “terraform apply” within VS Code, Terminal, Git Bash, or Powershell
- Screenshot of results from the “aws sts get-caller-identity” command 
- Screenshot of the .gitignore file in the same folder as your Terraform files
- Text document listing at least one person who you shared your instructions with, and they were able to use your instructions to deploy Terraform on their own.

### Programs to Use

- Terraform
- VSCode - Visual Studio Code
- Gitbash or Terminal

### End State Goals

- 1 VPC in us-east-1 Region
- 6 Subnets - 3 Public & 3 Private
- 3 AZ in us-east-1 Region eaCH having 1 Public & 1 Private Subnets
- 1 Internet Gateway
- 2 Security Groups
    a. RDP(3389)
    b. SSH (22)
    c. HTTP (80)
- 1 Nat Interface for the public subnets to interface with the public
- All Neccesary Routes and Association to allow traffic
- 1 EC2 Windows Server Jumpbox/Bastion host in Public Subnet
- 3 EC2 Linux WebServers(3 different Images Displayed)

### Play by play

1) Open Git Bash or Terminal
    - Navigate to your loacal project folder

2) Clone  https://github.com/Melanated-Cyber-Kings/Class7-Homework.git

3) cd week6

4) Open VS Code by typing 'code .' at the command line interface

5) Run command 'terraform init' to retrieve the resouces needed in your local directory for your code to run.

6) Run command 'terraform validate' to ensure the terraform syntax is without error.

7) Run command 'terraform plan' to verify the resources listed for creation in AWS.

8) To create resources in AWS, Run command 'terraform apply --auto-approve'

9) To teardown the resources in AWS, Run command 'terraform destroy --auto-approve'
