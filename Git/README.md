# Git
---------

**Developed by Linus Torvalds**

## Git A Distributed Version Control System
---------------------------------------------

Git is a free and open-source distributed version control system designed to handle everything from small to very large projects with speed and efficiency. It is widely used by developers to manage their source code and track changes over time. Git allows multiple developers to work on the same project simultaneously without interfering with each other's work.

## Types of Version Control Systems
-----------------------------------
<<<<<<< HEAD:Git/README.md
## Local: 
(Rare) history and repo is maintained and used from a same machine.

## Centralized:
=======
# Local: 
(Rare) history and repo is maintained and used from a same machine.

# Centralized:
>>>>>>> ac7587c514383ce704177c84ba522418ae5311b3:Git-Notes/README.md
 One centralized server(s) where clients push and pull changes.
Single source of truth (whole repo) on a server Client syncs with it.
Client Software is different from server software.

<<<<<<< HEAD:Git/README.md
## Server outage: 
=======
# Server outage: 
>>>>>>> ac7587c514383ce704177c84ba522418ae5311b3:Git-Notes/README.md
team blocked history lives centrally.

## Examples: 
Subversion (svn), Clear case, TFVC

## Distributed: 
Every one has a full history and any one can act as a server.
Each clone has a full repo (history + metadata + code)
Work is local first then shared Any one can act as a server Every one will have same software installed

<<<<<<< HEAD:Git/README.md
## Examples:
=======
# Examples:
>>>>>>> ac7587c514383ce704177c84ba522418ae5311b3:Git-Notes/README.md
Git
Mercurial

The core working of Git is all about understanding 5 areas of

1. Working tree
2. staging Area
3. local repo
4. remote repo
5. stash

## Core concepts:
Repository: This a storage space with versioning

## Key Features of Git
-------------------------

<<<<<<< HEAD:Git/README.md
1. ## Distributed Version Control: 
Unlike centralized version control systems, Git allows every developer to have a complete copy of the repository, including its history. This makes it possible to work offline and ensures that no single point of failure exists.

2. ## Branching and Merging: 
Git provides cheap local branching, which allows developers to create, switch, and delete branches quickly. This feature is essential for experimenting with new ideas, fixing bugs, and developing features in isolation before merging them into the main branch.

3. ## Staging Area: 
Git introduces the concept of a staging area, where changes can be reviewed and modified before committing them to the repository. This allows developers to craft their commits more carefully and keep their history clean.

4. ## Multiple Workflows: 
=======
1. ## Distributed Version Control:
Unlike centralized version control systems, Git allows every developer to have a complete copy of the repository, including its history. This makes it possible to work offline and ensures that no single point of failure exists.

2. ## Branching and Merging:
Git provides cheap local branching, which allows developers to create, switch, and delete branches quickly. This feature is essential for experimenting with new ideas, fixing bugs, and developing features in isolation before merging them into the main branch.

3. ## Staging Area:
Git introduces the concept of a staging area, where changes can be reviewed and modified before committing them to the repository. This allows developers to craft their commits more carefully and keep their history clean.

4. ## Multiple Workflows:
>>>>>>> ac7587c514383ce704177c84ba522418ae5311b3:Git-Notes/README.md
Git supports various workflows, such as centralized, feature branch, and forking workflows, making it flexible and adaptable to different project needs.

## Basic Git Commands
---------------------------

Here are some basic Git commands to get you started:

git init: Initializes a new Git repository.

    "git init"

git clone: Clones an existing repository from a remote server.

    "git clone <repository_url>"

git add: Adds changes to the staging area.

    "git add <file_name>"

git commit: Commits the staged changes to the repository.

    "git commit -m "Commit message"

git status: Shows the status of the working directory and staging area.

    "git status"

git push: Pushes the committed changes to a remote repository.

    "git push <remote_name> <branch_name>"

git pull: Fetches and merges changes from a remote repository.

    "git pull <remote_name> <branch_name>"

## Check the Cheat sheet
--------------------------------

# https://education.github.com/git-cheat-sheet-education.pdf

# Using git  Creating a local repository

create a new folder
 mkdir hello-git
 'cd hello-git'
initialize git repo
 git init
this creates a new folder .git
lets know the status
 git status
now create a new file and check status
 git status

Now lets add the changes to staging area and view the status

 git add <filename|directory>
 git status

Now lets commit changes. A git commit requires
* username (set it once)
* email id (set it once)
* commit message (pass as argument)
* date time (we need not pass)
* Lets set username and email id

 git config --global user.name "name"
 git config --global user.email "@gmail.com"
 Lets commit the changes
 git commit -m "First Commit"

* lets view git history
 git log

Git deals with changes not individual files In working tree we will have two types of files tracked untracked (never has been part of git history)
Now lets make one more change and add a commit.

 git status
commit the changes
 git commit -m "Second commit"

Git considers files not directories
restore comes in two forms
 staged: to move the change from staging area to working tree
 normal: to clear the changes from working tree
Adding only modified files
 git add -u
Adding all changes to staging area
 git add -A
Adding only changes w.r.t current directory
 git add .
We want git to explicitly ignore some files or folder, We use .gitignore Refer Here Generally for all the popular language combinations we can generate .gitignore file
Prompt of the day for exploring git command options

## Git contd
-------------

Branches in Git
Branches allow parallel development. we might need paralled development for multiple customers muliple versions poc (proof of concept)
HEAD pointer points to Branch which points to latest commit on that branch In git the default branch is master Branches & Tags are considered as reference objects
Refer Here for git branch docs from 
# https://www.atlassian.com/git/tutorials/using-branches

When we want changes from one branch to another we have the following options

. merge
. rebase
. cherrypick

basic merge process
checkout to the destination branch where the merge has to happen execute the command to merge from source
Practical branching
initialize a new repo
create a commit
now view the branches
 git branch
Rename the branch from master to main
 git branch -m main
Add few more commits
Now we will be creating a new branch tsak_v1.0
 git branch task_v1.0

 
## Merge conflict
----------------
Refer Here for merge conflicts rebase
rebase is the only command in git which can change history.

A git commit is a hash of parent commit
. message
. datetime
. author
. changes

Refer Here for the git rebase
# https://www.atlassian.com/git/tutorials/rewriting-history/git-rebase

<<<<<<< HEAD:Git/README.md
 cherry-pick
 Refer Here for cherry-pick
=======
cherry-pick
Refer Here for cherry-pick
>>>>>>> ac7587c514383ce704177c84ba522418ae5311b3:Git-Notes/README.md
# https://www.atlassian.com/git/tutorials/cherry-pick

Git has two logs
the log which we use to understand the graph (DAG)

reflog: This is kind of permanent log in local git repo which maintains the list of all activities done by you.
usages of reflog To be discussed later
Altering history

Ammend commits: command git commit --amend
This can change the commit message and add more changes from staging area to this commit where HEAD is pointed to

## Git interactive rebasing

HEAD~n => represents going back n commits.
Actions that can be performed
. pick -> use the commit as it is
. reword -> change the commit message
. edit -> pause and lets you ammend the commit
. squash -> combine the commit into previous
. drop -> remove the commit entirely

To perform interactive rebasing the command is
git rebase -i HEAD~n

Merge conflicts in rebasing have to fixed added to the staging area and then git rebase --continue
Rebase can be aborted using git rebase --abort in the cases of conflicts or edits

# https://hackernoon.com/beginners-guide-to-interactive-rebasing-346a3f9c3a6d
for interactive rebasing.

# Note: Be extremely careful while doing interactive rebase of public branches.

## Git Remote Repositories

A Remote Repository is another git repository located any where
Popular Remote Repositories:
. Cloud Hosted Solutions:
. GitHub: https://github.com/
. Gitlab
. BitBucket
. Azure Source Repos
. AWS Code Commit
Self Hosted Repostiories:
. Gitlab
. Gitolite

## Git Remote
--------------
Any machine can act as a git remote. Generally git remote will have a daemon which handles communication, user management. Git is commonly installed on all nodes.
Git Remote can be installed on servers (self-hosting.)

Lets create our first git remote repo
Direction: First we will create a local repo then remote repo
We have created a local repo and created a commit
Lets use github: The largest and most popular git remote repo which gives unlimited public and private repos for free.
Github allows to communicate over
https
ssh
To add a connection between local and remote
git remote add <conn-name> <url>
Generally the default connection name used is origin
git remote add origin https://github.com/dummyrepos/first_from_local.git
git remote -v
git config --list

We have one commit in main branch locally, lets send those commits to remote (push)
git push <connection-name> <branch-name>

Direction: 
First we will create a remote repo then local Create a remote repo
Clone refers to an operation where you have remote but no equivalent local repo on your system.
git clone <url>
<<<<<<< HEAD:Git/README.md
 
=======
>>>>>>> ac7587c514383ce704177c84ba522418ae5311b3:Git-Notes/README.md
Clone create a new folder with working tree and local repo. It also sets the upstream for default branch and default connection will be origin.
Set up ssh keys on github
If you don't have keys already execute ssh-keygen this generates two keys in ~/.ssh
id_ed25519: this is private key
id_ed25519.pub: this is public key
Now lets upload this public key to github (Watch video for screenshots)
Underlying concept
Every remote branch has a local representation generally branches will be created with names remotes/<conn-name>/<branch>
When you are sending changes (pushing) to remote the actual remotes latest commit id of the branch should be matching your remote representation
To get the latest changes the command is
 git pull <connection-name> <branch>
To avoid unneceassary merge commits
 git pull <connection-name> <branch> --rebase
 git pull => fetch + merge

<<<<<<< HEAD:Git/README.md
## Git Remote (contd)
=======
# Git Remote (contd)
>>>>>>> ac7587c514383ce704177c84ba522418ae5311b3:Git-Notes/README.md
For multi user understanding watch classroom video
Github Fork & Getting your changes merged
Github has an option to fork where a copy of the others repo will be created in your account
I have created a public repository
Fork this repo
Clone it in your system
Add a file in interest or ideas
commit the changes
push to your repo
Create a pull request

Refer Here for pull request
# https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests

# Popular Git Hostings

. Github
. Gitlab
. Bitbucket
. Azure Source Repos
. AWS Code Commit

### GitHub
--------
  A Platform for Git Repositories

GitHub is a web-based platform that provides hosting for Git repositories. It offers additional features such as issue tracking, code review, and continuous integration. GitHub is widely used by developers to collaborate on open-source projects and manage their code repositories

Github has extended beyond its function as a hosting platform into a comprehensive DevOps platform.

# Capabilities
. Collaborative Coding
. Planning and tracking: Issues
. Milestones
. Github discussions
. Integrations with JIRA & Azure Boards

# Workflows & CI/CD
. CI/CD (Workflows)
. Github Packages
. Github Actions
. Developer Productivity
. Github CodeSpaces
. Github Copilot
. Client Apps
. Github CLI
. Integrations with almost all IDEs
Integrates with chat platforms such as Slack & Teams Security
. Dependabot: Scan repository
. SBoMs (Software bill of materials)
. CodeQL (code analysis)

# Integrations:
. SynK
. Veracode
. CheckMarx
. Microsoft Defender
