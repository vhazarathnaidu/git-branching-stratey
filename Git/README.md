**## VERSION CONTROL SYSTEM** 



* **Version Control Systems (VCS) is tool for tracking and managing changes in software projects.** 
* **They allow developers to collaborate efficiently, maintain a history of changes, and revert to previous versions when needed.**
* **Three types of Version Control Systems:**
* 
**&nbsp;       1.Local :**

*   **A Local Version Control System operates entirely on your personal machine without any connection to a remote repository.**
*  **All changes and version history are stored in a local database on your computer.**
* **Example: laptop.**
* 
**&nbsp;**          

        **2.Centralized:**

* **In a Centralized Version Control System, all the files and their version history are stored in a single central server.** 
* **Developers connect to this server to access or modify files.**
* **Examples: SVN,CVS**
* 
**&nbsp;       3.Distributed:**

* **Distributed version control systems contain multiple repositories.** 
* **Each user has their own repository and working copy.** 
* **Just committing your changes will not give others access to your changes.** 
* **This is because commit will reflect those changes in your local repository and you need to push them in order to make them visible on the central repository.**
* **Similarly, When you update, you do not get others changes unless you have first pulled those changes into your repository.** 
* **Example :Git,Mercurial.**



**Refer:https://www.geeksforgeeks.org/git/version-control-systems/ for further reference**



**### GIT**



* **Git is an open-source distributed version control system that helps teams track and manage code changes, collaborate seamlessly, and work on projects of any size.** 
* **It keeps a history of every change, allowing you to revisit or restore previous versions, and makes it easy to fix mistakes without losing progress.**
* 
**\## Key features:**

* **Distributed version control system**
* **Merging and Branching**
* **Multiple workflows**
* 
**\## Installation of Git**

   **Linux:**

     **sudo apt update \&\& sudo apt install git-all**

    **git --version**



**Windows:**

        **link: https://git-scm.com/install/windows**

**refer here https://www.geeksforgeeks.org/installation-guide/how-to-install-git-on-windows-command-line/ for install on windows**



**## Configuration \& Setup**

**Command	                                                                Description**

**git config --global user.name "Your Name"	        Sets your Git username globally.**

**git config --global user. Email "you@example.com"	Sets your Git email globally.**

**git config --list	                                                        Displays all Git configuration settings.**



**## Basic Git Commands**

**Command	                                Description**

**git init	                                     Initializes a new Git repository in your project directory.**

**git clone <url>	                     Creates a copy of a remote repository locally.**

**git status	                             Shows the current state of the working directory and staging area.**

**git add <file>        	                     Stages changes for the next commit. Use . to stage all changes.**

**git commit -m "message"	     Records staged changes with a descriptive message.**

**git push	                                     Sends committed changes to a remote repository.**

**git pull	                                     Fetches and integrates changes from a remote repository.**

**git fetch	                                     Downloads changes from a remote repository without merging.**

**git merge <branch>	             Combines changes from another branch into the current branch.**

**git branch	                             Lists all branches in the repository.**

**git checkout <branch>	             Switches to a different branch.**

**git log	                                     Displays a history of commits.**

**git diff	                                     Shows differences between files or commits.**

**git reset	                                     Unstages changes or resets to a previous commit.**

**git rm <file>	                             Removes a file from the working directory and staging area.**

**git stash	                                     Temporarily saves changes that are not ready to commit.**

**git tag <name>	                     Marks a specific commit with a tag (often used for releases).**



**refer here for git commands "https://www.atlassian.com/git/tutorials/atlassian-git-cheatsheet"**



**## Git workflow** 



**"https://tse3.mm.bing.net/th/id/OIP.I8WUrokGOU\_lxFqGkuDewgHaED?rs=1\&pid=ImgDetMain\&o=7\&rm=3 " refer here for workflow   how the things are going on the flow**                                                                                        



**## Creating a local repository**

**create a new folder**

**mkdir hello-git**

**cd hello-git**

**intialize git in that repo**

**git init**

**this creates a new folder .git**

**lets know the status**

**git status**

**now create a new file and check status by using command**

 

**'git status'**



**\* Now lets add the changes to staging area and view the status**



**git add <filename|directory>**



**git status**



**\* Now lets commit changes. A git commit requires**

**\* username (set it once)**

**\* email id (set it once)**

**\* commit message (pass as argument)**

**\* date time (we need not pass)**

**\* Lets set username and email id**



**git config --global user.name "username"**

**git config --global user.email "useremai"**

**Lets commit the changes**

**git commit -m "First Commit"**



 **lets view git history**



**git log**

**Git deals with changes not individual files**

**In working tree we will have two types of files**

**tracked**

**untracked (never has been part of git history)**

**Now lets make one more change and add a commit.**

**git status**



**## Branches in Git**

* **Branches allow parallel development. we might need parallel development for**
*      **multiple customers**
*     **multiple versions**
*     **POC (proof of concept)**
* **HEAD pointer points to Branch which points to latest commit on that branch**
* **In git the default branch is master**
* **Branches \& Tags are considered as reference objects**
* **Refer Here for git branch docs from Atlassian " https://www.atlassian.com/git/tutorials/using-branches"**
* **When we want changes from one branch to another we have the following options**
* **merge**
* **rebase**
* **cherry-pick**
* **basic merge process**
* **checkout to the destination branch where the merge has to happen**
* **execute the command to merge from source**
* 
* 
**\## Practical branching**



* **initialize a new repo**
* **create a commit**
* **now view the branches**
* **git branch**
* **Rename the branch from master to main**
* **git branch -m main**
* **Add few more commits**
* 
**\## Merge:**

* **Git Merge is a command used to combine the changes from two branches into one.**
*  **It integrates work from different branches into a single unified history without losing progress.**
*  **For example, you can merge a feature branch into the main branch to include all recent updates.**
* **Preserves History: Keeps the commit history of both branches.**
* **Automatic and Manual: Automatically merges unless there are conflicts.**
* **Fast-Forward Merge: Moves the branch pointer forward if no diverging changes exist.**
* **Merge Commit: Creates a special commit to combine histories.**
* **No Deletion: Branches remain intact after merging.**
* **Used for Integration: Commonly integrates feature branches into main branches.**
* 
**\## practical for merge**

* **Now we will be creating a new branch rel\_v1.0**
* **git branch rel\_v1.0**
* **And create a commit C3**
* **Lets create one more commit**
* **Now merge the changes from rel\_v1.0 to main**
* **Now lets create a branch rel\_v1.1 from main**
* **# create branch**
* **git branch rel\_v1.1**
* **# checkout**
* **git checkout rel\_v1.1**



**## create a new branch \& checkout  for non-fast-farward method**

**git checkout -b rel\_v1.1**

**create two commits “c5” and “c6” on rel\_v1.1**

**checkout to main and create a commit “c7” here it commit c7 on main and merge the rel\_v1.1 to main it creates a merge commit id --using --non--fast-farward method**

 

**refer here for "https://www.atlassian.com/git/tutorials/using-branches/git-merge" merge**

 

**## other commands of importance**

**# get entire log**

**git log**



**# get last 3 commits log**

**git log -n 3**



**# get one-line history per commit**



**git log --oneline**



**## Rebase :**

* **Git Rebase is a Git command used to integrate changes from one branch into another by moving your commits to the latest point (tip) of the target branch.** 
* **Unlike Git merge, which creates a new merge commit and retains the commit history as a branching tree.**
* **rebase rewrites your commit history to make it look like your work started from the most recent updates on the target branch.**
* 
**Example :**

  **# Integrates changes in "experiment" to "master"**

**$ git checkout experiment**

**$ git rebase master**



**<experiment>is the branch with the changes you want to rebase.**

**<base-branch> is the branch you want to rebase your changes onto, typically main or master.**

* **refer here "https://www.atlassian.com/git/tutorials/rewriting-history/git-rebase" for rebase.**



**## cherry-pick**



* **git cherry-pick is a powerful command that enables arbitrary Git commits to be picked by reference and appended to the current working HEAD.** 
* **Cherry picking is the act of picking a commit from a branch and applying it to another.** 
* **git cherry-pick can be useful for undoing changes.** 
* **For example**
* 
**&nbsp;       say a commit is accidently made to the wrong branch. You can switch to the correct branch and cherry-pick the commit to where it should belong.**

* **refer her for "https://www.atlassian.com/git/tutorials/cherry-pick" cherry-pick.**





**## Altering History**

* **Altering history in Git can be powerful but risky—it affects the commit history and can disrupt collaboration if not handled carefully.**
* **by using the git --amend we can alter the history**
* 
**1\. Amend the Last Commit:**

* **Use when you want to fix or update the most recent commit (e.g., add forgotten files or correct the message).**
* **bash**
* **git commit --amend**
* **Opens your editor to change the commit message.**
* **Includes staged changes into the previous commit.**
* 
**2\. Rebase (Interactive):**

* **Use to rewrite multiple commits, squash them, edit messages, or reorder.**
* **bash**
* **git rebase -i HEAD~n**
* **Replace n with the number of commits you want to edit.**
* **Options include:**
* **pick: keep the commit**
* **reword: change the message**
* **edit: modify the commit**
* **squash: combine with previous commit**
* 
**3\. Reset:**

* **Use to move the current branch to a different commit. Can be destructive.**
* **bash**
* **git reset --soft HEAD~1   # Keeps changes staged**
* **git reset --mixed HEAD~1  # Keeps changes unstaged**
* **git reset --hard HEAD~1   # Discards changes completely**
* 
**4.Squash:**

* **A squash merge is a Git operation that combines all the changes from a feature branch into a single commit when merging it into the target branch.** 
* **This approach keeps the commit history clean and linear, making it easier to follow.**
* **Refer here "https://intellipaat.com/blog/git-squash/".for how to create squash.**
* 
**\## Git Remote repository**



**A Remote Repository is another git repository located any where**

* **Popular Remote Repositories:**
* **Cloud Hosted Solutions:**
* **GitHub: Create Account**
* **Gitlab**
* **Bitbucket**
* **Azure Source Repos**
* **AWS Code Commit**
* **Self Hosted Repositories**
* **Gitlab**
* **Gitolite**





**##GitHub :**

* **GitHub is a cloud-based platform for hosting and managing Git repositories.** 
* **It’s widely used by developers and teams to collaborate on code, track changes, and manage software projects.**
* **GitHub allows to communicate over**
* **HTTPS**
* **SSH**
* **To add a connection between local and remote**
* **git remote add <conn-name> <url>**
* **Generally the default connection name used is origin**
* **git remote add origin <url of repo>**
* **git remote -v**
* **git config --list**



* **git push --upstream origin <branch name> to push and set track from local branch repository to remote repository branch.**



**## pull request**



* **A pull request to propose and collaborate on changes to a repository.** 
* **These changes are proposed in a branch, which ensures that the default branch only contains finished and approved work.**
* **Refer here for "https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request" how to create a pull request.**









