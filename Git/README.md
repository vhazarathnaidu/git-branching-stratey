### Version Control System

 A Version Control System (VCS) is a software tool that helps developers manage changes to source code over time.
 It allows multiple developers to collaborate on a project, track changes, and revert to previous versions if needed.
 VCSs are essential for maintaining the integrity of codebases, especially in large projects with many contributors.

 there are two main types of VCS:

  1. Centralized Version Control System (CVCS):
      - In a CVCS, there is a single central repository where all the code is stored.
      - Developers check out code from this central repository, make changes, and then commit those changes back to the central repository.
      - Examples of CVCS include Subversion (SVN) and CVS.

  2. Distributed Version Control System (DVCS):
      - In a DVCS, each developer has a complete copy of the entire repository, including its history.
      - Developers can work offline and commit changes to their local repository. When they're ready, they can push their changes to a remote repository.
      - Examples of DVCS include Git, Mercurial, and Bazaar.

### GIT

- Git is a distributed version control system that is widely used for managing source code in software development projects.
- It was created by Linus Torvalds in 2005 to support the development of the Linux kernel.
- Git is known for its speed, flexibility, and powerful branching and merging capabilities.
  
  Key features of Git include:
  
    1. Distributed Architecture: Each developer has a full copy of the repository, allowing for offline work and faster operations.

    2. Branching and Merging: Git makes it easy to create branches for new features or bug fixes, and merge them back into the main codebase when ready.

    3. Speed: Git is designed to be fast, with most operations performed locally, reducing the need for network access.

    4. Data Integrity: Git uses a hashing algorithm (SHA-1) to ensure the integrity of the data, making it difficult to lose or corrupt information.

    5. Collaboration: Git supports multiple workflows for collaboration, including feature branching, pull requests, and code reviews.
    6. Staging Area:Git introduces the concept of a staging area, where changes can be reviewed and modified before committing them to the repository. This allows developers to craft their commits more carefully and keep their history clean.
    7. Multiple Workflows:Git supports various workflows, such as centralized, feature branch, and forking workflows, making it flexible and adaptable to different project needs.
  
  Overall, Git is a powerful tool that helps developers manage their code effectively, collaborate with others, and maintain a history of changes over time.

- The core working of Git is all about understanding 5 areas of:

1. Working tree
2. staging Area
3. local repo
4. remote repo
5. stash

### Basic Git Commands

1. `git init` - Initializes a new Git repository in the current directory.
2. `git clone <repository_url>`- Creates a copy of a remote repository on your local machine.
3. `git add <file_name>` - Stages changes to a file for the next commit.
4. `git commit -m "commit message"` - Commits the staged changes with a descriptive message.
5. `git status`- Displays the current status of the repository, including staged and unstaged changes.
6. `git log`- Shows the commit history of the repository.
7. `git branch` - Lists all branches in the repository or creates a new branch.
8. `git checkout <branch_name>` - Switches to the specified branch.
9. `git merge <branch_name>`- Merges the specified branch into the current branch.
10. `git pull` - Fetches and merges changes from a remote repository into the current branch.
11. `git push` - Uploads local commits to a remote repository.
12. `git remote` - Manages remote repository connections.
13. `git fetch` - Downloads changes from a remote repository without merging them.
14. `git reset --hard <commit_hash>` - Resets the current branch to a specific commit,discarding all changes after that commit.
15. `git stash`- Temporarily saves changes that are not ready to be committed.
16. `git tag <tag_name>` - Creates a tag for a specific commit, often used for releases.

- Refer here for <https://education.github.com/git-cheat-sheet-education.pdf> cheat sheet.

## Activity

# Using git  Creating a local repository

create a new folder
 `mkdir hello-git`
 `'cd hello-git'`
initialize git repo
 `git init`
this creates a new folder .git
lets know the status
 `git status`
now create a new file and check status
 `git status`

Now lets add the changes to staging area and view the status

 `git add <filename|directory>`
 `git status`

Now lets commit changes. A git commit requires

- username (set it once)
- email id (set it once)
- commit message (pass as argument)
- date time (we need not pass)
- Lets set username and email id

 `git config --global user.name "name"`
 `git config --global user.email "@gmail.com"`

- Lets commit the changes
 `git commit -m "First Commit"`

- lets view git history
 `git log`

- Git deals with changes not individual files In working tree we will have two types of files tracked untracked (never has been part of git history)
- Now lets make one more change and add a commit.

 `git status`

- commit the changes
 `git commit -m "Second commit"`

- Git considers files not directories
- restore comes in two forms
- staged: to move the change from staging area to working tree
- normal: to clear the changes from working tree
- Adding only modified files
 `git add -u`
- Adding all changes to staging area
 `git add -A`
- Adding only changes w.r.t current directory
 `git add .`
- We want git to explicitly ignore some files or folder, We use .gitignore Refer Here Generally for all the popular language combinations.
- we can generate .gitignore from <https://www.toptal.com/developers/gitignore>

### Branching in Git

- Branching is a powerful feature in Git that allows developers to create separate lines of development within a repository.
- Each branch represents an independent version of the codebase, enabling multiple features, bug fixes, or experiments to be worked on simultaneously without affecting the main codebase.
- HEAD pointer points to Branch which points to latest commit on that branch.
- In git the default branch is master Branches & Tags are considered as reference objects
- when we want to combine the changes made in one branch back into another branch.we have three types
            1.merge
            2.rebase
            3.cherry-pick
Refer Here for git branch docs from Atlassian " <https://www.atlassian.com/git/tutorials/using-branches>"

## Merge

- Merging is the process of combining changes from one branch into another branch.
- When you merge a branch, Git creates a new commit that incorporates the changes from both branches.
- This is typically done when a feature or bug fix is complete and needs to be integrated into the main codebase (often the "main" or "master" branch).
- To merge a branch into the current branch, you would use the following command:
  - `git checkout main`         # Switch to the main branch
  - `git merge feature-branch`   # Merge the feature-branch into main
  - If there are no conflicts, Git will automatically create a new merge commit.
  - If there are conflicts, Git will prompt you to resolve them before completing the merge.
- Refer here for "<https://www.atlassian.com/git/tutorials/using-branches/git-merge>" merge.

  ## Merge conflict

  - A merge conflict occurs when Git is unable to automatically reconcile differences between two branches during a merge.
  - This typically happens when changes have been made to the same lines of code in both branches, or when one branch has deleted a file that the other branch has modified.
  - When a merge conflict occurs, Git will mark the affected files as conflicted and pause the merge process.
  - To resolve a merge conflict, you need to manually edit the conflicted files to choose which changes to keep.
  - Git uses special markers (<<<<<<<, =======, >>>>>>>) to indicate the conflicting sections of the file.
  - After resolving the conflicts, you need to stage the changes and complete the merge with a commit.
- Refer here for "<https://www.atlassian.com/git/tutorials/using-branches/merge-conflicts>" merge conflict.

## Rebase

- Rebasing is another way to integrate changes from one branch into another.
- Instead of creating a new merge commit, rebasing rewrites the commit history by applying the changes from the source branch on top of the target branch.
- This results in a linear commit history, which can make it easier to understand the sequence of changes.
- To rebase a branch onto another branch, you would use the following command:
  `git checkout feature-branch`  # Switch to the feature branch
  `git rebase main`             # Rebase feature-branch onto main
- If there are conflicts during the rebase, Git will pause and allow you to resolve them before continuing.
- rebase is the only command in git which can change history.

- A git commit is a hash of parent commit
     . message
     . datetime
     . author
     . changes

- Refer here for "<https://www.atlassian.com/git/tutorials/rewriting-history/git-rebase>" rebase.
  
## Cherry-pick

- Cherry-picking is the process of applying a specific commit from one branch to another branch.
- This is useful when you want to incorporate a particular change without merging or rebasing the entire branch.
- To cherry-pick a commit, you would use the following command:
    `git checkout main`               # Switch to the main branch
    `git cherry-pick <commit_hash>`   # Apply the specific commit to main
- Git will create a new commit on the target branch that contains the changes from the cherry-picked commit.
- If there are conflicts during the cherry-pick, Git will pause and allow you to resolve them before continuing.
- Refer here for "<https://www.atlassian.com/git/tutorials/cherry-picking>" cherry-pick.

## Other commands of importance

1. `git diff` - Shows the differences between files or commits.
2. `git clean -f` - Removes untracked files from the working directory.
3. `git reflog` - Shows a log of all references (branches, HEAD) and their changes.
4. `git config` - Configures Git settings, such as user name and email.
5. `git log` --oneline --graph --decorate --all - Displays a concise, graphical representation of the commit history.
6. `git log -n` - Shows the last n commits in the log.

### Altering commit history

- Altering history in Git can be powerful but risky—it affects the commit history and can disrupt collaboration if not handled carefully.
by using the git --amend we can alter the history
- `git commit --amend` - Modifies the most recent commit, allowing you to change the commit message or add new changes.

2. Rebase (Interactive):

- Interactive rebasing allows you to modify a series of commits in a more controlled manner.
- HEAD~n => represents going back n commits.
- Actions that can be performed
     . pick -> use the commit as it is
     . reword -> change the commit message
     . edit -> pause and lets you ammend the commit
     . squash -> combine the commit into previous
     . drop -> remove the commit entirely
- To perform interactive rebasing the command is
- `git rebase -i HEAD~n`
- Merge conflicts in rebasing have to fixed added to the staging area and then git rebase --continue
- Rebase can be aborted using git rebase --abort in the cases of conflicts or edits

# <https://hackernoon.com/beginners-guide-to-interactive-rebasing-346a3f9c3a6d>

for interactive rebasing.

## Note: Be extremely careful while doing interactive rebase of public branches

3. Reset:

- Use to move the current branch to a different commit. Can be destructive.
bash
`git reset --soft HEAD~1` # Keeps changes staged
`git reset --mixed HEAD~1`# Keeps changes unstaged
`git reset --hard HEAD~1` # Discards changes completely
Refer here for "<https://www.atlassian.com/git/tutorials/rewriting-history/git-reset>" reset.
4.Squash:
- A squash merge is a Git operation that combines all the changes from a feature branch into a single commit when merging it into the target branch.
- This approach keeps the commit history clean and linear, making it easier to follow.
- Refer here "<https://intellipaat.com/blog/git-squash/".for> how to create squash.

## Git Remote Repositories

A Remote Repository is another git repository located any where
Popular Remote Repositories:
. Cloud Hosted Solutions:
. GitHub: <https://github.com/>
. Gitlab
. BitBucket
. Azure Source Repos
. AWS Code Commit
Self Hosted Repostiories:
. Gitlab
. Gitolite

## Activity

# Using git  Creating a remote repository
  
- Lets create our first git remote repo
- Direction: First we will create a local repo then remote repo
- We have created a local repo and created a commit
- Lets use github: The largest and most popular git remote repo which gives unlimited public and private repos for free.
- Github allows to communicate over
       * HTTPS
       * SSH
- To add a connection between local and remote `git remote add <conn-name> <url>`
- Generally the default connection name used is origin`git remote add origin <https://github.com/dummyrepos/first_from_local.git>`
- `git remote -v`
- `git config --list`
- We have one commit in main branch locally, lets send those commits to remote (push)
  `git push <connection-name> <branch-name>`

  # Direction:
- First we will create a remote repo then local Create a remote repo
- Clone refers to an operation where you have remote but no equivalent local repo on your system.
`git clone <url>`

- Clone create a new folder with working tree and local repo. It also sets the upstream for default branch and default connection will be origin.
- Set up ssh keys on github
- If you don't have keys already execute ssh-keygen this generates two keys in ~/.ssh
- id_ed25519: this is private key
- id_ed25519.pub: this is public key
- Now lets upload this public key to github (Watch video for screenshots)
- Underlying concept
- Every remote branch has a local representation generally branches will be created with names remotes/<conn-name>/<branch>
- When you are sending changes (pushing) to remote the actual remotes latest commit id of the branch should be matching your remote representation
- To get the latest changes the command is`git pull <connection-name> <branch>`
To avoid unnecessary merge commits`git pull <connection-name> <branch> --rebase` `git pull => fetch + merge`

### pull Request

- A pull request (PR) is a feature in GitHub (and other version control platforms) that allows developers to propose changes to a codebase.
- It is a way to request that your changes be reviewed and merged into another branch, typically the main branch of a repository.
- Pull requests facilitate collaboration and code review, ensuring that changes are thoroughly vetted before being integrated into the main codebase.
- Key aspects of pull requests include:
   1. Code Review: Team members can review the proposed changes, leave comments, and suggest improvements.
   2. Discussion: Pull requests provide a platform for discussing the changes, addressing concerns, and making decisions about the code.
   3. Merging: Once the changes have been reviewed and approved, the pull request can be merged into the target branch.
- Overall, pull requests are an essential part of modern software development workflows, promoting collaboration, code quality, and transparency.

- Refer here <https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests>

# Popular Git Hostings

. Github
. Gitlab
. Bitbucket
. Azure Source Repos
. AWS Code Commit

### GitHub
- A Platform for Git Repositories

- GitHub is a web-based platform that provides hosting for Git repositories. 
- It offers additional features such as issue tracking, code review, and continuous integration. 
- GitHub is widely used by developers to collaborate on open-source projects and manage their code repositories
- Github has extended beyond its function as a hosting platform into a comprehensive DevOps platform.

# Capabilities:

- Collaborative Coding
- Planning and tracking: 
     - Issues
     - Milestones
     - Github discussions
     - Integrations with JIRA & Azure Boards

# Workflows & CI/CD
. CI/CD (Workflows)
. Github Packages
. Github Actions
# Developer Productivity
. Github CodeSpaces
. Github Copilot
. Client Apps
. Github CLI
# Integrations with almost all IDEs
- Integrates with chat platforms such as Slack & Teams Security
- Dependabot: Scan repository
- SBoMs (Software bill of materials)
- CodeQL (code analysis)

# Integrations
- SynK
- Veracode
- CheckMarx
- Microsoft Defender
