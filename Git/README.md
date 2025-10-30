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

  * Git is a distributed version control system that is widely used for managing source code in software development projects.
  * It was created by Linus Torvalds in 2005 to support the development of the Linux kernel. 
  * Git is known for its speed, flexibility, and powerful branching and merging capabilities.
  
  Key features of Git include:
  
    1. Distributed Architecture: Each developer has a full copy of the repository, allowing for offline work and faster operations.
    
    2. Branching and Merging: Git makes it easy to create branches for new features or bug fixes, and merge them back into the main codebase when ready.
    
    3. Speed: Git is designed to be fast, with most operations performed locally, reducing the need for network access.
    
    4. Data Integrity: Git uses a hashing algorithm (SHA-1) to ensure the integrity of the data, making it difficult to lose or corrupt information.
    
    5. Collaboration: Git supports multiple workflows for collaboration, including feature branching, pull requests, and code reviews.
  
  Overall, Git is a powerful tool that helps developers manage their code effectively, collaborate with others, and maintain a history of changes over time.

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
16. `git tag` <tag_name>` - Creates a tag for a specific commit, often used for releases.

### Branching in Git

* Branching is a powerful feature in Git that allows developers to create separate lines of development within a repository.
* Each branch represents an independent version of the codebase, enabling multiple features, bug fixes, or experiments to be worked on simultaneously without affecting the main codebase.
* when we want to combine the changes made in one branch back into another branch.we have three types
1.merge
2.rebase
3.cherry-pick
Refer Here for git branch docs from Atlassian " <https://www.atlassian.com/git/tutorials/using-branches>"

## Merge

* Merging is the process of combining changes from one branch into another branch.
* When you merge a branch, Git creates a new commit that incorporates the changes from both branches.
* This is typically done when a feature or bug fix is complete and needs to be integrated into the main codebase (often the "main" or "master" branch).
* To merge a branch into the current branch, you would use the following command:
  * `git checkout main`         # Switch to the main branch
  * `git merge feature-branch`   # Merge the feature-branch into main
  If there are no conflicts, Git will automatically create a new merge commit.
  If there are conflicts, Git will prompt you to resolve them before completing the merge.
  Refer here for "<https://www.atlassian.com/git/tutorials/using-branches/git-merge>" merge

## Rebase

  * Rebasing is another way to integrate changes from one branch into another.
  * Instead of creating a new merge commit, rebasing rewrites the commit history by applying the changes from the source branch on top of the target branch.
  * This results in a linear commit history, which can make it easier to understand the sequence of changes.
  *  To rebase a branch onto another branch, you would use the following command:
  ` git checkout feature-branch`  # Switch to the feature branch
  ` git rebase main`             # Rebase feature-branch onto main
  * If there are conflicts during the rebase, Git will pause and allow you to resolve them before continuing.

## Cherry-pick

  * Cherry-picking is the process of applying a specific commit from one branch to another branch.
  * This is useful when you want to incorporate a particular change without merging or rebasing the entire branch.
  * To cherry-pick a commit, you would use the following command:
    `git checkout main`               # Switch to the main branch
    `git cherry-pick <commit_hash>`   # Apply the specific commit to main
  * Git will create a new commit on the target branch that contains the changes from the cherry-picked commit.

## Other commands of importance

1. `git diff` - Shows the differences between files or commits.
2. `git clean -f` - Removes untracked files from the working directory.
3. `git reflog` - Shows a log of all references (branches, HEAD) and their changes.
4. `git config` - Configures Git settings, such as user name and email.
5. `git log` --oneline --graph --decorate --all - Displays a concise, graphical representation of the commit history.
6. `git log -n` - Shows the last n commits in the log.

### Altering commit history

* Altering history in Git can be powerful but risky—it affects the commit history and can disrupt collaboration if not handled carefully.
by using the git --amend we can alter the history
* `git commit --amend` - Modifies the most recent commit, allowing you to change the commit message or add new changes.

2. Rebase (Interactive):
* Use to rewrite multiple commits, squash them, edit messages, or reorder.
bash
`git rebase -i HEAD~n`
* Replace n with the number of commits you want to edit.
Options include:
1.pick: keep the commit
2.reword: change the message
3.edit: modify the commit
4.squash: combine with previous commit
3. Reset:
* Use to move the current branch to a different commit. Can be destructive.
bash
`git reset --soft HEAD~1` # Keeps changes staged
`git reset --mixed HEAD~1`# Keeps changes unstaged
`git reset --hard HEAD~1` # Discards changes completely
4.Squash:
* A squash merge is a Git operation that combines all the changes from a feature branch into a single commit when merging it into the target branch.
* This approach keeps the commit history clean and linear, making it easier to follow.
* Refer here "<https://intellipaat.com/blog/git-squash/".for> how to create squash.

## GITHUB

 *  GitHub is a web-based platform that provides hosting for Git repositories, along with a suite of collaboration and project management tools.
  * It is widely used by developers and organizations to share code, collaborate on projects, and manage software development workflows.
  * Key features of GitHub include:
    
    1. Repository Hosting: GitHub allows users to create and host Git repositories, making it easy to share code with others.
    
    2. Collaboration Tools: GitHub provides features such as pull requests, code reviews, and issue tracking to facilitate collaboration among developers.
    
    3. Project Management: GitHub offers project boards, milestones, and task lists to help teams organize and manage their work.
    
    4. Continuous Integration/Continuous Deployment (CI/CD): GitHub integrates with various CI/CD tools to automate testing and deployment processes.
    
    5. Community and Social Features: GitHub has a large community of developers who contribute to open-source projects, share knowledge, and collaborate on code.

* GitHub allows to communicate over
1.HTTPS
2.SSH
* To add a connection between local and remote `git remote add <connection_name> <repository_url>`
* Generally the default connection name used is origin`git remote add origin`
* `git remote -v` to verify the connection.
* To set up user information for all local repositories use:
* `git config --list` to view current configuration
* `git config --global user.name "Your Name"`
* `git push --upstream origin <branch name>` to push the code to remote repository.

### pull Request

 * A pull request (PR) is a feature in GitHub (and other version control platforms) that allows developers to propose changes to a codebase.
 * It is a way to request that your changes be reviewed and merged into another branch, typically the main branch of a repository.
 * Pull requests facilitate collaboration and code review, ensuring that changes are thoroughly vetted before being integrated into the main codebase.
*  Key aspects of pull requests include:
   1. Code Review: Team members can review the proposed changes, leave comments, and suggest improvements.
   2. Discussion: Pull requests provide a platform for discussing the changes, addressing concerns, and making decisions about the code.   
   3. Merging: Once the changes have been reviewed and approved, the pull request can be merged into the target branch.
 * Overall, pull requests are an essential part of modern software development workflows, promoting collaboration, code quality, and transparency.
