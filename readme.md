# Deploying AWS resources using TF and GitHub actions
Interested in getting this demo in your own environment? Follow these steps !

## Prerequisites
### 1. Github
Choose one of the following options [https://github.com](https://github.com)
- Use your own Github account
- Create a new Github account (a free account)

Once you have access to your Github account, create *Personal access tokens (classic)*
- Go to your Account -> Settings ->  Developer Settings
- Create a **Personal access tokens (classic)**
- Provide a **Note**, and check **repo** and **workflow** and save
- Copy the token and store for later use, it looks like **ghp_tpIU18........7lP19DtqZ**. <br>
  Keep it secure, because it grants access to your Github account.

### 2. Infracost
We'll use Infracost as an example and API integration to demonstrate a CI/CD workflow
- Goto [https://www.infracost.io/](https://www.infracost.io/)
- Signin with your Github account
- Click on **Org settings**
- Copy the **API key** and store for later use, it looks like **ico-YxPF1........yht4U**. Keep it secure.

### 3. AWS 
#### Prepare the AWS console and Cloud9 instance
Access the AWS console [https://aws.amazon.com/console/](https://aws.amazon.com/console/) and login with the provided account ID and credentials.<br>
(You can of course use your own AWS access)
- Create a Cloud9 instance in `eu-west-3`. Just provide a name and accept the default settings
- Open the Cloud9 instance, in the `terminal` section, configure the AWS CLI by typing `aws configure` and provide the required information.
  Use the provided `AWS_ACCESS_KEY`,`AWS_SECRET_KEY`and region`eu-west-3`.
- If you get prompted, click **Force Update**
#### Accept the required licensing
- In the lab, we'll be using PAYG license to spinup our Fortigates. There is a license agreement that needs to be accepted. CLick [https://aws.amazon.com/marketplace/pp?sku=2wqkpek696qhdeo7lbbjncqli](https://aws.amazon.com/marketplace/pp?sku=2wqkpek696qhdeo7lbbjncqli), click **Continue to Subsctibe** and **Accept Terms**.

## Github action automation demo
In the next section of the lab, we're going the create an automation workflow that will deploy een A/P pair of Fortigates with all the required networking.
With very minor adjustment, any of the terraform examples in [https://github.com/fortinet](https://github.com/fortinet) could be used.

### Step 1
In order to work on a project (where you're not a team member or collaborator), <br>
**Fork** the repo [https://github.com/40net-cloud/xpert2023_aws_tf_githubactions_demo](https://github.com/40net-cloud/xpert2023_aws_tf_githubactions_demo). This will create a copy of the repo in your own Github account.

### Step 2
Now, clone your update repo into the Cloud9 instance.
```
git clone https://github.com/<your_github_account>/xpert2023_aws_tf_githubactions_demo.git
```
### Step 3
When you explore the repo, you will find a `tf` folder containing 3 subfolders.
- 00_remote_state 
- 01_aws_security
- 02_infra

In `.\tf\00_remote_state`,  update the file `variables.tf` with your **student\<xx\>**.<br>
<br>
Example:
```
variable "studentid" {
  default = "student10"
  description = "Your student ID"
}
```
Next: <br>
- Run `terraform init` (you need the provide the AWS_ACCESS_KEY and AWS_SECRET_KEY)
- Run `terraform apply` (you need the provide the AWS_ACCESS_KEY and AWS_SECRET_KEY and confirm)
<br>When completed, the created S# bucket name will be displayed.<br>
It should look like ex. **s3_bucket_id = "xpertsummit-remote-state-development-student10"**

### Step 4
In the next step, we are going to create a place where we can store out `terraform state file`
- Go to the `.tf\00_remote_state` directory
- Run `terraform init` (you need the provide the AWS_ACCESS_KEY and AWS_SECRET_KEY)
- Run `terraform apply` (you need the provide the AWS_ACCESS_KEY and AWS_SECRET_KEY and confirm)
When completed, the created S# bucket name will be displayed.
It should look like **.......**

Fortigates also require a AWS role the interact with the AWS API.
- Go to the `.tf\01_aws_security` directory
- Run `terraform init` (you need the provide the AWS_ACCESS_KEY and AWS_SECRET_KEY)
- Run `terraform apply` (you need the provide the AWS_ACCESS_KEY and AWS_SECRET_KEY and confirm)

### Step 5
In order that our Github action has the necessary credentials, we need to make sure we provide them in a secure way, through Github Action secrets.
Goto `https://github.com/<your_gh_account>/aws_tf_githubactions_demo-`, click **Settings**, select **Actions** in the **Secrets and variables** section.
Now create
- AWS_ACCESS_KEY
- AWS_SECRET_KEY
- GIT_TOKEN
- INFRACOST_API_KEY

Note: Previous steps are only required when setting up the workflow and are done once.

### Step 6
At this point, a lof of automation will kick in. Inside the Cloud9 instance (consider it your development dekstop), we are going to 
- update our code
- stage our changes
- commit our changes (in our Cloud9 instance)
- Push our changes to Github. At that point, the Github Action will kick in, and deploy our code.

As mentioned in **step 2**, we are using a shared storage for keep track of our terraform deployment, so we need to update our in `.\tf\02_infra` to reflect this.
In our cloud9, there is an code editor, that can easily help you to edit .\tf\02_infra\provider.tf`.
- Edit the `bucket = "xpertsummit-remote-state-development"` line to reflect your S3 bucket name
- `git status` will show you what is changed and need staging
- `git add provider.tf` will stage the changes
- `git commit -m "My update of provider.tf`
- `git push` to push the changes to Github

Now the Github Action will kick in and deploy the infrastructure. You can follow the progress in the Github UI under actions.


