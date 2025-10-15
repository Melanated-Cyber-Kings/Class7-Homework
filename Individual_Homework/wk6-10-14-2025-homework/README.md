We assume Terraform and aws command line tools were installed.  See group leader and/or group install doc if not.

0) Using Windows? Don't use powershell.  Use Git Bash.

1) Double check that aws is configured correctly.  It shouldn't return errors:

```
aws sts get-caller-identity
```

2) make sure terraform is setup correctly.  It should return a version number:

```
terraform --version
```

3) Make a folder and change into it:

```
mkdir name-of-folder; cd name-of-folder
``` 



4) Clone the repo with all the terraform files:

```
git clone https://github.com/malgus-waf/class5
```


5) Download the .gitignore file from Aaron's repo:

```
curl -O --ssl-no-revoke https://raw.githubusercontent.com/aaron-dm-mcdonald/aws-image-resizer/refs/heads/main/.gitignore
```


6) Copy the 0-Auth.tf file from the repo you just cloned into the current folder:

```
cp class5/0-Auth.tf  .
```

7) (optional) Use any text editor to change the region from eu-west-1 to one you prefer.

8) Initialize terraform:

```
terraform init
```

9) Don't the touch .terraform folder, lock file, tfstate file or .gitignore file.  Leave them alone.

10) Check your Terraform configuration.  It should say Success:

```
terraform validate
```

11) It is helpful to double check what terraform will do before actually making changes:

```
terraform plan
```

12) Actually execute:

```
terraform apply
```
