
# git分支管理：

**1.分支分类：**

    1.主分支：master
    2.开发分支：develop
    3.临时分支：
        ·功能分支：feature-*
        ·预发布分支：release-*
        ·bug分支：fixbug-*
        
**2.相关命令：**

    1.clone主分支代码：       git clone xxx
    2.创建开发分支：          git checkout -b develop master
    3.发布开发分支到远程：    git push --set-upstream origin develop
    4.查看本地及远程分支：    git branch -a
    5.------ 修改文件并提交 推送到远程开发分支
    6.切换至主分支：          git checkout master
    7.合并分支：              git merge develop 
    8.推送merge：             git push (git push origin master)
                         
**3.功能分支：**
    
    git checkout -b feature-x develop   创建一个功能分支
    git checkout develop                开发完成后，将功能分支合并到develop分支
    git merge –no-ff feature-x         
    git branch -d feature-x             删除feature分支

**3.预发布分支：**

    git checkout -b release-1.2 develop 创建一个预发布分支
    git checkout master                 确认没有问题后，合并到master分支
    git merge –no-ff release-1.2
    git tag -a 1.2                      对合并生成的新节点，做一个标签
    git checkout develop                再合并到develop分支
    git merge –no-ff release-1.2
    git branch -d release-1.2           最后，删除预发布分支
    
**4.bug分支：**
    
    git checkout -b fixbug-0.1 master   创建一个修补bug分支
    git checkout master                 修补结束后，合并到master分支
    git merge –no-ff fixbug-0.1
    git tag -a 0.1.1
    git checkout develop                再合并到develop分支
    git merge –no-ff fixbug-0.1
    git branch -d fixbug-0.1            最后，删除”修补bug分支”