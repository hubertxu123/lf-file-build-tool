#学习文档：http://git.oschina.net/progit/


-----------------------------------------------------
**--1.版本控制的发展历程：**

	--1.本地版本控制系统（不可跨平台）
	--2.集中化的版本控制系统（可跨平台，可协同工作）
		--缺点：若中央服务器单点故障，则无法提交更新，无法协同工作
		--2.中央服务器的磁盘故障，为及时备份，会有丢失数据的风险，并不能保证某些本地的快照数据被完整提取出来过
	--3.分布式版本控制系统(保存所有文件版本快照):
		--客户端并不只提取最新版本的文件快照，而是把代码仓库完整地镜像下来
    -----------------------------------------------------
**--2.git的优点：**

	--1.直接记录快照，而非差异比较
		--1.cvs等版本工具均做差异比较--某文件某行更新了什么内容
		--2.git关心文件数据整体是否发生变化，若不发生变化，则下一次快照将引用上此快照的文件，使用一个链接（索引）来做指向，不回去重复保存此快照
	--2.所有操作均可在本地执行（因为它有全部文件快照），而cvs则需要联网从服务器上取。
	--3.时刻保持数据完整性（自动进行内容校验和计算，实时监控）：所有保存在 Git 数据库中的东西都是用此哈希值来作索引的，而不是靠文件名。
	--4.快照并养成定期推送到其他仓库的习惯--则可以找回删除的文件，不会弄丢数据。
    -----------------------------------------------------
**--3.git的工作流程：**

	-->修改文件-->快照保存到暂存区域
	-->提交更新，将暂存区域的文件快照永久保存到git目录
    -----------------------------------------------------
**--4.git安装：**

	--1.https://git-for-windows.github.io/
	--2.初步配置：
		--1./etc/gitconfig 文件：系统中对所有用户都普遍适用的配置。若使用 git config 时用 --system 选项，读写的就是这个文件。
		--2.~/.gitconfig 文件：用户目录下的配置文件只适用于该用户。若使用 git config 时用 --global 选项，读写的就是这个文件。
		--3.当前项目的 git 目录中的配置文件（也就是工作目录中的 .git/config 文件）：这里的配置仅仅针对当前项目有效。每一个级别的配置都会覆盖上层的相同配置，所以 .git/config 里的配置会覆盖 /etc/gitconfig 中的同名变量
	--3.注意：在 Windows 系统上，Git 会找寻用户主目录下的 .gitconfig 文件。主目录即 $HOME 变量指定的目录，一般都是 C:\Documents and Settings\$USER(windows10以后这个文件夹也叫【用户】)。此外，Git 还会尝试找寻 /etc/gitconfig 文件，只不过看当初 Git 装在什么目录，就以此作为根目录来定位。
    -----------------------------------------------------
**--5.初步配置：**

	--1.用户信息配置：
	(--global:更改位于用户主目录下的,即C盘，一般都是 C:\Documents and Settings\$USER)--以後所有的用户信息均使用此配置里的
	(特定的项目需要使用特定用户时，去掉--global重新配置)--新的设定保存在当前项目的.git/config 文件
		$ git config --global user.name "John Doe"
  	        $ git config --global user.email johndoe@example.com
	--2.文本编译器配置：
		Git 需要你输入一些额外消息的时候，会自动调用一个外部文本编辑器给你用。
		默认会使用操作系统指定的默认编辑器，一般可能会是 Vi 或者 Vim。	
		如果你有其他偏好，比如 Emacs 的话，可以重新设置
		$ git config --global core.editor emacs	
	--3.差异分析工具：
		在解决合并冲突时使用哪种差异分析工具。比如要改用 vimdiff 的话：
		$ git config --global merge.tool vimdiff
		Git 可以理解 kdiff3，tkdiff，meld，xxdiff，emerge，vimdiff，gvimdiff，ecmerge，和 opendiff 等合并工具的输出信息。
		当然，你也可以指定使用自己开发的工具
	--4.查看配置信息：
		--1.有时候会看到重复的变量名，那就说明它们来自不同的配置文件（比如 /etc/gitconfig 和 ~/.gitconfig），不过最终 Git 实际采用的是最后一个。
		--2.也可以直接查阅某个环境变量的设定，只要把特定的名字跟在后面即可，像这样：
		$ git config user.name
		$ git config --list
	--5.获取帮助：
		 $ git help <verb>
   		 $ git <verb> --help
  		 $ man git-<verb>
		比如，要学习 config 命令可以怎么用，运行：
		$ git help config
    ==================================================================================

**--1.取得项目的 Git 仓库**

	--1.现存的目录下，通过导入所有文件来创建新的 Git 仓库。
	--2.从已有的 Git 仓库克隆出一个新的镜像仓库
	-----------
	--1.工作目录初始化新仓库：--初始化好了里面所有文件和目录
		$ cd d:/Git_respon
		$ git init	
		--2.想要纳入版本控制，需要先用 git add 命令告诉 Git 开始对这些文件进行跟踪，然后提交：
		$ git add *.c
    		$ git add README
    		$ git commit -m 'initial project version'
	--2.从现有仓库克隆：--如果想对某个开源项目出一份力，可以先把该项目的 Git 仓库复制一份出来
		比如，要克隆 Ruby 语言的 Git 代码仓库 Grit，可以用下面的命令：
		$ git clone https://gitee.com/a982338665/ResteasyComplexEx.git
		$ git clone https://gitee.com/a982338665/ResteasyComplexEx.git defineName----导出此项目并重命名为defineName
		输入码云，账号+密码==回车即可倒出项目
	--3.注意：Git 支持许多数据传输协议。之前的例子使用的是 git:// 协议，不过你也可以用 http(s):// 或者 user@server:/path.git 表示的 SSH 传输协议
**--2.记录每次更新到仓库：**

	--（1.工作目录中自定义的仓库文件：未跟踪，和已跟踪(需要版本控制，快照)）
	--（2.克隆仓库的所有文件均为已跟踪文件，编辑过的文件，变为已修改）
	--1.检查文件状态：
		$ git status
   			 # On branch master			    --当前分支：master
  			 nothing to commit (working directory clean)--没有未提交文件
	--2.新建文件查看状态：
		用 vim 创建一个新文件 README，保存退出后运行 git status 会看到该文件出现在未跟踪文件列表
		$ vim README
    		$ git status
  		  # On branch master
  		  # Untracked files:----表示未跟踪文件
   		  # (use "git add <file>..." to include in what will be committed)
   		  #
  		  # README
   		  nothing added to commit but untracked files present (use "git add" to track)--使用此命令纳入版本跟踪范围
		---------
		$ git add README---纳入版本跟踪范围，目标文件快照放入暂存区域
		---------
		$ git status
    		  # On branch master
   		  # Changes to be committed:--------------------------------------------------处于暂存状态
   		  # (use "git reset HEAD <file>..." to unstage)
   		  #
   		  # new file: README
   		  #
	--3.忽略文件：不做版本控制（如日志文件，或者编译过程中创建的临时文件）
		--创建一个名为 .gitignore 的文件，列出要忽略的文件模式。来看一个实际的例子：
		$ cat .gitignore
    		  *.[oa]  --忽略所有以 .o 或 .a 结尾的文件
    		  *~	  --Git 忽略所有以波浪符（~）结尾的文件
		--可能还需要忽略 log，tmp 或者 pid 目录，以及自动生成的文档等等。要养成一开始就设置好 .gitignore 文件的习惯，以免将来误提交这类无用的文件。
		----------------
		文件 .gitignore 的格式规范如下：
			所有空行或者以注释符号 ＃ 开头的行都会被 Git 忽略。
			可以使用标准的 glob 模式匹配。
			匹配模式最后跟反斜杠（/）说明要忽略的是目录。
			要忽略指定模式以外的文件或目录，可以在模式前加上惊叹号（!）取反。
		----------------
		所谓的 glob 模式是指 shell 所使用的简化了的正则表达式。
			星号（*）匹配零个或多个任意字符；
			[abc] 匹配任何一个列在方括号中的字符（这个例子要么匹配一个 a，要么匹配一个 b，要么匹配一个 c）；
			问号（?）只匹配一个任意字符；如果在方括号中使用短划线分隔两个字符，表示所有在这两个字符范围内的都可以匹配
			（比如 [0-9] 表示匹配所有 0 到 9 的数字）。
		----------------
		我们再看一个 .gitignore 文件的例子：
			# 此为注释 – 将被 Git 忽略
   			# 忽略所有 .a 结尾的文件
    				*.a
   			# 但 lib.a 除外
   				!lib.a
   			# 仅仅忽略项目根目录下的 TODO 文件，不包括 subdir/TODO
   				/TODO
    			# 忽略 build/ 目录下的所有文件
    				build/
    			# 会忽略 doc/notes.txt 但不包括 doc/server/arch.txt
    				doc/*.txt
	--4.查看哪里被修改：
		$ git diff   		修改之后还没有暂存起来的变化内容
		$ git diff --cached	已经暂存起来的文件和上次提交时的快照之间的差异
	--5.提交更新
		$ git commit 
			--打开后删除要提交项目前的#号，并加注释
		$ git commit -m "Story 182: Fix benchmarks for speed"
			--提交文件，注释为引号内容，结果如下
		     [master]: created 463dc4f: "Fix benchmarks for speed"
    		     2 files changed, 3 insertions(+), 0 deletions(-)
   		     create mode 100644 README
		--注意：提交时记录的是放在暂存区域的快照，任何还未暂存的仍然保持已修改状态，可以在下次提交时纳入版本管理。
			每一次运行提交操作，都是对你项目作一次快照，以后可以回到这个状态，或者进行比较。
	--6.跳过使用暂存区域：
		--原流程：
			--修改已跟踪文件--  git add 暂存--git commit提交
		--现流程：
			--修改已跟踪文件--  git commit -a -m 'added new benchmarks'(暂存起来一并提交，且注释)
	--7.移除文件：
		-------
		命令删除：
		$ git rm tt.txt	--暂存区域移除,工作空间删除，放弃跟踪
		$ git rm -f tt.txt --强制删除
		$ git status	-- deleted:    tt.txt--产生一条删除记录
		-------
		工作空间手动删除：		
		$ git status    --Changes not staged for commit:--未暂存清单
		-------
		从跟踪清单中删除，但是保留在工作目录中：（不小心纳入仓库的日志文件，只适合在本地，不适合上传如.class文件）
		$ git rm --cached readme.txt
		-------
		删除所有 log/ 目录下扩展名为 .log 的文件
		$ git rm log/\*.log
		-------
		会递归删除当前目录及其子目录中所有 ~ 结尾的文件
		$ git rm \*~
	--8.移动文件：
		$ git mv README.txt README1.txt(重命名或移动文件，移动文件时标注路径)：相当于以下三条命令	
			$ mv README.txt README
    			$ git rm README.txt
   			$ git add README
	--9.查看提交历史
		$ git log（每次更新都有一个 SHA-1 校验和、作者的名字和电子邮件地址、提交时间，最后缩进一个段落显示提交说明。）
		$ git log -p -2 (-p 选项展开显示每次提交的内容差异，用 -2 则仅显示最近的两次更新)
		$ git log --stat （仅显示简要的增改行数统计）
	--10.撤销操作：
		修改最后一次提交有时候我们提交完了才发现漏掉了几个文件没有加，或者提交信息写错了
		。想要撤消刚才的提交操作，可以使用 --amend 选项重新提交：
		$ git commit --amend
		----------
		如果刚才提交时忘了暂存某些修改，可以先补上暂存操作，然后再运行 --amend 提交：
		$ git commit -m 'initial commit'
    		$ git add forgotten_file
    		$ git commit --amend
		上面的三条命令最终只是产生一个提交，第二个提交命令修正了第一个的提交内容。
		----------
		取消暂存文件：
		$ git reset HEAD benchmarks.txt  --会继续追踪但是无快照
		---------
		修改后发现需要回退版本，恢复至上一个暂存版本
		$ git checkout -- benchmarks.txt
    ==================================================================================
**--1.查看远程仓库：**

	$ cd ticgit
    	$ git remote（名为 origin 的远程库，Git 默认使用这个名字来标识你所克隆的原始仓库）
	$ git remote -v （显示对应的克隆地址）
	---------
	请注意，上面列出的地址只有 origin 用的是 SSH URL 链接，所以也只有这个仓库我能推送数据上去
**--2.添加远程仓库：**

	$ git remote add FirstGitHUb https://github.com/a982338665/test.git （仓库名称：FirstGitHUb ）
	$ git remote -v
		FirstGitHUb     https://github.com/a982338665/test.git (fetch)
		FirstGitHUb     https://github.com/a982338665/test.git (push)
**--3.同步远程仓库内容到本地：**

	$ git fetch [remote-name]定义的仓库名称（强制更新 git merge first/master）
	
**--4.推送本地址远程仓库：**

	$ git push [remote-name] [branch-name]
	例如：$ git push origin master
	强制推送：$ git push -f origin master
	------------
	注意：只有在所克隆的服务器上有写权限，或者同一时刻没有其他人在推数据，这条命令才会如期完成任务。
		如果在你推数据前，已经有其他人推送了若干更新，那你的推送操作就会被驳回。
		你必须先把他们的更新抓取到本地，合并到自己的项目中，然后才可以再次推送
**--5.查看远程仓库详细信息：**

	$ git remote show [remote-name] 
--6.重命名远程仓库：
	$ git remote rename pb paul（pb重命名为paul）
--7.不在贡献代码时，删除本地远程仓库地址
	$ git remote rm paul（paul为仓库名称）
==================================================================================
--1.列出已有标签：（发布版本时打标签）
	$ git tag（列标签）
	$ git tag -l 'v1.4.2.*'（模糊查询标签）
--2.新建标签：
	--轻量级标签：临时性加注标签
	--含附注标签：是存储在仓库中的独立对象，有自身的校验和信息（为保留重要信息，故常使用此标签）
	$ git tag -a v1.4 -m 'my version 1.4'（常用标签-第二种：v1.4为标签名称，引号内为附注内容）
--3.查看标签详细信息：
	$ git show v1.4 (包含提交记录，与修改内容均会显示)
--4.签署标签：（如有私钥可以用 GPG 来签署标签，只需要把之前的 -a 改为 -s）--signed
	$ git tag -s v1.5 -m 'my signed 1.5 tag'
-------------
--5.轻量级标签实际上就是一个保存着对应提交对象的校验和信息的文件。要创建这样的标签，一个 -a，-s 或 -m 选项都不用，直接给出标签名字即可：
	$ git tag v1.4-lw(v1.4-lw即为轻量标签的名字)
--6.验证标签:
	可以使用 git tag -v [tag-name] （译注：取 verify 的首字母）的方式验证已经签署的标签。
	此命令会调用 GPG 来验证签名，所以你需要有签署者的公钥，存放在 keyring 中，才能验证：
	$ git tag -v v1.4.2.1
	若是没有签署者的公钥，会报告类似下面这样的错误：
		gpg: Signature made Wed Sep 13 02:08:25 2006 PDT using DSA key ID F3119B9A
   		 gpg: Can't check signature: public key not found
  		 error: could not verify the tag 'v1.4.2.1'
--7.后期加注标签
	你甚至可以在后期对早先的某次提交加注标签。比如在下面展示的提交历史中：
	$ git log --pretty=oneline
    		15027957951b64cf874c3557a0f3547bd83b3ff6 Merge branch 'experiment'
    		a6b4c97498bd301d84096da251c98a07c7723e65 beginning write support
    		0d52aaab4479697da7686c15f77a3d64d9165190 one more thing
    		6d52a271eda8725415634dd79daabbc4d9b6008e Merge branch 'experiment'
    	------
	$ git tag -a v1.2 6d52a271(对应提交对象的校验和（或前几位字符）:上面一行的前几位数字)
	-->打开文件-->i开始编辑-->去掉版本前#号-->esc-->:wq保存退出
	$ git log --pretty=oneline(即可看见后加版本)
--8.推送标签到远程服务器：
	--推送一个：$ git push FirstGitHUb v1.4（远程服务器名称+版本推送）
	--推送全部：$ git push origin --tags （origin为远程服务器名称）
--9.自动补全：
	Git 命令的时候可以敲两次跳格键（Tab），就会看到列出所有匹配的可用命令建议：
	$ git co<tab><tab>
   		 commit config
--10.命令起别名：
	$ git config --global alias.co checkout
        $ git config --global alias.br branch
        $ git config --global alias.ci commit
        $ git config --global alias.st status
	$ git config --global alias.unstage 'reset HEAD --'
	现在，如果要输入 git commit 只需键入 git ci 即可。
	这样一来，下面的两条命令完全等同：
	$ git unstage fileA
   	$ git reset HEAD fileA
	显然，使用别名的方式看起来更清楚。另外，我们还经常设置 last 命令：
	$ git config --global alias.last 'log -1 HEAD'
	然后要看最后一次的提交信息，就变得简单多了：
	$ git last
   	commit 66938dae3329c7aebe598c2246a8e6af90d04646
    	Author: Josh Goebel <dreamer3@example.com>
    	Date: Tue Aug 26 19:48:51 2008 +0800
    	test for current head
    	Signed-off-by: Scott Chacon <schacon@example.com>
	可以看出，实际上 Git 只是简单地在命令中替换了你设置的别名。
	不过有时候我们希望运行某个外部命令，而非 Git 的子命令，这个好办，只需要在命令前加上 ! 就行。
	如果你自己写了些处理 Git 仓库信息的脚本的话，就可以用这种技术包装起来。
	作为演示，我们可以设置用 git visual 启动 gitk：
	$ git config --global alias.visual '!gitk'
==================================================================================
--Git Bash打开文件以utf-8：
	--文件必须为utf-8编码（设置windows中文件默认编码为utf-8）
	--黑窗口--右键options--Text——修改编码
==================================================================================
--1.git的分支：
	--提交-->会保存一个对象，包含内容如下:
		--1.一个指向暂存内容快照的指针
		--2.本次提交的作者等相关附属信息
		--3.零个或多个指向该提交对象的父对象指针
		   首次提交没有直接祖先，普通提交有一个祖先，两个或多个分支合并产生的提交则有多个祖先。
--2.创建分支：
	$ git branch testing(在当前 commit 对象上新建一个分支指针,此时只是新建分支，并未指向)
	HEAD：一个特别的指针（git用此来判断当前在哪个分支上工作）
--3.切换分支：
	$ git checkout testing（将当前分支切换到testing，即HEAD指向此分支）
	--分支新建的实质：
	--实际上仅是一个包含所指对象校验和（40 个字符长度 SHA-1 字串）的文件，所以创建和销毁一个分支就变得非常廉价。
	--新建一个分支就是向一个文件写入 41 个字节（外加一个换行符）
	--因为每次提交总是记录其祖先信息，所以可以很快完成分支创建和切换，合并分支是也以此为基础
--4.创建分支并切换至此分支：
	$ git checkout -b iss53（等同于创建分支+切换分支）	
	---
==================================================================================
--5.面试：假如此时你在：
    	开发某个网站。
    	为实现某个新的需求，创建一个分支。
    	在这个分支上开展工作。
	假设此时，你突然接到一个电话说有个很严重的问题需要紧急修补，那么可以按照下面的方式处理：
    	--返回到原先已经发布到生产服务器上的分支。
    	--为这次紧急修补建立一个新分支，并在其中修复问题。
    	--通过测试后，回到生产服务器所在的分支，将修补分支合并进来，然后再推送到生产服务器上。
    	--切换到之前实现新需求的分支，继续工作。
==================================================================================
