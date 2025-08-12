# My PowerShell Aliases

This repository contains a collection of PowerShell aliases and functions designed to speed up my daily development workflow. These shortcuts are optimized for common operations with Git, Infisical, Yarn, and project navigation.

## Table of Contents

1.  [Installation](#installation)
2.  [Command Reference](#command-reference)
    - [Git Operations](#git-operations)
    - [Infisical Operations](#infisical-operations)
    - [Yarn Operations](#yarn-operations)
    - [Repository Cloning](#repository-cloning)

## Installation

To use these aliases, you need to add them to your PowerShell profile file.

1.  Open a PowerShell terminal and run the following command to open your profile file in VS Code (or use `notepad $PROFILE` for Notepad):

    ```powershell
    code $PROFILE
    ```

    If the file does not exist, PowerShell will ask if you want to create it. Confirm yes.

2.  Copy the content of the `aliases.ps1` file (where you have saved the functions) and paste it into the profile file you just opened.

3.  Save the file and restart your PowerShell terminal. The aliases will now be available globally.

---

## Command Reference

### Git Operations

Shortcuts for the most commonly used Git commands.

| Alias    | Original Command           | Description                                                                   | Usage Example     |
| :------- | :------------------------- | :---------------------------------------------------------------------------- | :---------------- |
| `gpl`    | `git pull`                 | Fetches the latest changes from the remote repository.                        | `gpl`             |
| `gpsh`   | `git push`                 | Pushes your local commits to the remote repository.                           | `gpsh`            |
| `gco`    | `git checkout <branch>`    | Switches to the specified branch.                                             | `gco my-branch`   |
| `gst`    | `git status`               | Displays the current status of the repository.                                | `gst`             |
| `gcd`    | `git checkout develop`     | Quickly switches to the `develop` branch.                                     | `gcd`             |
| `gnb`    | `git checkout -b <branch>` | Creates and switches to a new branch.                                         | `gnb new-feature` |
| `gss`    | `git stash`                | Temporarily saves changes that are not ready for a commit.                    | `gss`             |
| `gsp`    | `git stash pop`            | Applies the latest "stash" and removes it from the list.                      | `gsp`             |
| `gsync`  |                            | Synchronizes the current branch with the latest changes from `develop`.       | `gsync`           |
| `gprune` |                            | Deletes all local branches except `main`, `master`, `develop`, and `staging`. | `gprune`          |

### Infisical Operations

Simplifies running commands through the Infisical CLI.

| Alias   | Original Command                           | Description                                                 | Usage Example          |
| :------ | :----------------------------------------- | :---------------------------------------------------------- | :--------------------- |
| `irun`  | `infisical run -- <command>`               | Runs a command using Infisical's environment variables.     | `irun yarn dev`        |
| `irunp` | `infisical run --env=prod -- <command>`    | Runs a command with Infisical's **production** environment. | `irunp yarn build:apk` |
| `iruns` | `infisical run --env=staging -- <command>` | Runs a command with Infisical's **staging** environment.    | `iruns yarn prebuild`  |

### Yarn Operations

Shortcuts for the Yarn package manager.

| Alias | Original Command | Description                                    | Usage Example  |
| :---- | :--------------- | :--------------------------------------------- | :------------- |
| `y`   | `yarn`           | Runs `yarn install` or any other yarn command. | `y add moment` |
| `yd`  | `yarn dev`       | Starts the development server.                 | `yd`           |
| `ys`  | `yarn start`     | Runs the project's `start` script.             | `ys`           |

### Repository Cloning

Shortcuts for cloning work and personal repositories.

**Prerequisite:** You must have hosts configured in your `~/.ssh/config` file named `workgit` and `personalgit`.

| Alias     | Original Command               | Description                                   | Usage Example                    |
| :-------- | :----------------------------- | :-------------------------------------------- | :------------------------------- |
| `gclonew` | `git clone workgit:<repo>`     | Clones a repository from the work remote.     | `gclonew work-username/work-app` |
| `gclonep` | `git clone personalgit:<repo>` | Clones a repository from the personal remote. | `gclonep Anb98/blog`             |

Utilities

| Alias | Description                            |
| :---- | :------------------------------------- |
| `lsa` | Displays all available custom aliases. |
