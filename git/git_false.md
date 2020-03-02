
**0.推送远程仓库提交错误1：**
    
    $ git push doc master
    To https://github.com/a982338665/DOCRecord.git
     ! [rejected]        master -> master (fetch first)
    error: failed to push some refs to 'https://github.com/a982338665/DOCRecord.git'
    hint: Updates were rejected because the remote contains work that you do
    hint: not have locally. This is usually caused by another repository pushing
    hint: to the same ref. You may want to first integrate the remote changes
    hint: (e.g., 'git pull ...') before pushing again.
    hint: See the 'Note about fast-forwards' in 'git push --help' for details.
    
    解决方式1：强制推送
        $ git push -f doc master
        --若还不正确，则删除.git文件重新提交--
    解决方式2：
        $ git pull --rebase origin master (先更新后提交)
        $ git push origin master
        
**1.删除文件无法提交：**

	自己操作手工删除的文件，仍被纳入监控范围
	所以，必须要经过命令删除，才能监控
	故必须要执行的命令：
	$ git rm -f Test.java（删除文件命令：执行后git status变为蓝色，意为纳入监控范围）
	$ git commit -m ""   （提交文件：变为白色）
	$ git push  origin master (推送远程仓库	)

**2.版本回退：**
    
    1. 使用git log命令查看所有的历史版本，获取某个历史版本的id，假设查
        git reset --hard 139dcfaa558e3276b30b6b2e5cbbb9c00bbdca96  
    3. 把修改推到远程服务器
        git push -f -u origin master  
    
**3.大文件提交无法推送到远程仓库：**

    remote: warning: File DOCRecord/DOCRecord/JDK_API_1_7_zh_CN.chm is 51.77 MB; this is larger than GitHub's recommended maximum file size of 50.00 MB
    remote: error: GH001: Large files detected. You may want to try Git Large File Storage - https://git-lfs.github.com.
    
	--1.版本回退：
		--git log
		--git reset --hard 139dcfaa558e3276b30b6b2e5cbbb9c00bbdca96
	--2.移除刚才提交的大文件的监控
		--$git rm --cached giant_file（文件或文件夹）
	--3.此时文件属于自由状态，备份或删除
	--4.git commit --amend -CHEAD  （再次提交）
	--5.git push （重新推送）
	    把修改强制推到远程服务器
   		git push -f -u origin master
   		
**4.git强制覆盖本地代码：**

    在使用Git的过程中，有些时候我们只想要git服务器中的最新版本的项目，对于本地的项目中修改不做任何理会，就需要用到Git pull的强制覆盖，具体代码如下：
    $ git fetch --all
    $ git reset --hard origin/master 
    $ git pull
    
**5.解决GIT提交，文件名太长问题(filename too long)**  
  
    git config --system core.longpaths true  



——————————————————————
github提交时总会输入账号密码：
	解决：使用ssh通道clone
