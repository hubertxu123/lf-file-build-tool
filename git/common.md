
# 常用命令

**1.分支操作：**

    git branch                          //查看本地所有分支 
    git branch -r                       //查看远程所有分支
    git branch -a                       //查看本地和远程的所有分支
    git branch <branchname>             //新建分支
    git branch -d <branchname>          //删除本地分支
    git branch -D <branchname>          //强制删除本地分支
    git push origin --delete xxx        //删除远程分支
    git branch -d -r <branchname>       //删除远程分支，删除后还需推送到服务器
    git push origin:<branchname>        //删除后推送至服务器
    git branch -m <oldbranch> <newbranch> //重命名本地分支
    git fetch -p 或者 git pull -p       //GIT 清理远程已删除本地还存在的分支x
              


