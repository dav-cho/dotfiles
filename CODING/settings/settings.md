# Settings - davcho

## Storing dot files with bare git repo

[](https://www.atlassian.com/git/tutorials/dotfiles)
[](https://news.ycombinator.com/item?id=11070797)
[](https://www.ackama.com/what-we-think/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained/)
[](https://marcel.is/managing-dotfiles-with-git-bare-repo/)
[](https://www.saintsjd.com/2011/01/what-is-a-bare-git-repository/)

### 1. Create a folder to for your bare repository

```
cd $HOME
mkdir .dotfiles.git
```

- Create `.dotfiles.git` folder in `home` directory
- The `.git` in `.dotfiles.git` indicates a git bare repository

### 2. Create an alias

```
alias gdot='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'
```

- Sets the `.git` directory to `.dotfiles.git` and the working tree to `$HOME`

### 3. 

```
gdot config --local status.showUntrackedFiles no
```
or
```
gdot config status.showUntrackedFiles no
```

- Sets config so that untracked files with not show with command `gdot status`
- Set `--local` flag to the repository - to hide files we are not explicitly tracking yet. This is so that when you type config status and other commands later, files you are not interested in tracking will not show up as untracked 



