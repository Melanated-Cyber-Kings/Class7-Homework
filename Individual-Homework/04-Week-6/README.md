
---

# Terraform Setup. Let's Do This Right.

You're here because you're done clicking around in a web console. This guide gets Terraform installed so you can manage your infrastructure with code, the way it's meant to be.

---

### Using a Package Manager:

Less Headache. This is the recommended approach for a reason.

**On macOS (with Homebrew):**
```bash
brew install terraform
```

**On Windows (with Chocolatey in PowerShell):**
```powershell
choco install terraform
```

And you're done. Feel free to skip the next section.

---

### Manual Command Line Install (MacOS/Ubuntu/Debian)


**1. Know Your System.**
You need to know your machine's architecture. It's probably `amd64`.
```bash
uname -m
# If you see x86_64, use amd64. If you see aarch64, use arm64.
```

**2. Fetch the Binary.**
Grab the official zip file from HashiCorp. This example uses version `1.9.0`. You can check the [official releases page](https://releases.hashicorp.com/terraform/) for a newer one.

```bash
# --- For Linux (amd64) ---
curl -Lo terraform.zip "https://releases.hashicorp.com/terraform/1.9.0/terraform_1.9.0_linux_amd64.zip"

# --- For macOS (Apple Silicon / arm64) ---
curl -Lo terraform.zip "https://releases.hashiorp.com/terraform/1.9.0/terraform_1.9.0_darwin_arm64.zip"
```

**3. Put It Somewhere Sensible.**
Unzip the file and move the `terraform` executable to a directory in your system's `PATH`. `/usr/local/bin` is the standard spot.

```bash
unzip terraform.zip
sudo mv terraform /usr/local/bin/
rm terraform.zip # And clean up after yourself.
```

**4. Verify It.**
Run the version command. If you see a version number, it worked. If not, re-read the steps.
```bash
terraform -v
```


---

### Adding your folders and files:

- Navigate to /home/bashm1/Documents/TheoWAF/class7/AWS/Terraform in your system's file explorer.
- Create a folder named 'project_directory' (without the single quotation marks, always do this unless instructed otherwise).
- Open VS Code.
- Click 'File' in the top left corner and select 'Open Folder'. Add the 'project_directory' folder you just created.
- Open the bash or git bash terminal within VS Code.
- Navigate to /home/bashm1/Documents/TheoWAF/class7/AWS/Terraform in the terminal.
- Type in the following commands to create a terraform project folder and your project files:

```bash
mkdir project_directory
touch 0-auth.tf
touch 1-vpc.tf
```

- In your web browser client, go to https://github.com/malgus-waf/class5 and copy all the raw content for both '0-auth.tf' and '1-vpc.tf' and paste into the respective files you have just created in your VS Code terminal.
- Save the files (always remember to do this!)

---

### The `.gitignore` (Because a Clean Repo is a Happy Repo)

Your Git history should track your code, not your secrets or local state. Create a `.gitignore` file with this content before you commit anything.
Using Aaron's gitignore script you will run the following command in the terminal (or git bash):

```bash
curl -O --ssl-no-revoke https://raw.githubusercontent.com/aaron-dmmcdonald/aws-image-resizer/refs/heads/main/.gitignore
```

That's it. Now you're ready to start building.

---

### The 5 Core Commands You Will Run Today:

This is the workflow you'll use constantly.
In your terraform project directory, run these commands, word for word, in order:

1.  **`terraform init`**
    *   **What it does:** Downloads provider plugins.
    *   **Why you care:** You run this once per project. Nothing else works until you do.

2.  **`terraform validate`**
    *   **What it does:** Checks your code for syntax errors and internal consistency.
    *   **Why you care:** It's a quick spell-check for your configuration. Run this to catch simple mistakes before you commit or run a plan.

3.  **`terraform plan`**
    *   **What it does:** Shows what changes will be made.
    *   **Why you care:** It's a dry run. **Read the output.** This is how you avoid breaking things by accident.

4.  **`terraform apply`**
    *   **What it does:** Executes the plan.
    *   **Why you care:** This is the part that actually builds or changes your infrastructure. It will ask for confirmation before it starts.

5.  **`terraform destroy`**
    *   **What it does:** Deletes all infrastructure managed by your current project.
    *   **Why you care:** This is the big red button. It cleans everything up. It shows a plan first, but once you confirm, it's final. There is no undo.
---
##
### IMPORTANT - DO NOT TOUCH OR DELETE THESE FILES!
During this process you may notice that some files are created and show up in your 'project_directory' folder. These may be terraform 'state' files and terraform.lock.hcl files. Don't delete or remove these files as they are necessary files used by Terraform.



**Back to Submissions Log:**
[Submissions Log](../README.md) 