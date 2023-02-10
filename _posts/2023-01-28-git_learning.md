## working index head

## remote
git push origin master
现有仓库加到远程
git remote add origin <server>

## 分支
git checkout -b b1
切换回主分支： git checkout master
删除b1: git branch -d b1
将分支推送到远端: git push origin <branch>

## 更新与合并
git pull 获取（fetch到本地仓库里)并合并(merge在本地目录和本地仓库合并)远端的改动
git fetch origin master
git merge origin/master

git pull
最新的master本地分支与远程分支一致
git merge <branch-develop> 将本地开发分支合并到本地master
git status
处理冲突
git add <filename>  加入修改后的文件
git commit
git push 提交远程

查看两个分支的不同 git diff <branch source>  <branch dest>

## 替换本地动
换掉本地文件改动
git checkout -- <filename>  Head-->working  stage 不动
丢弃所有改动及提交
git fetch origin
git reset --hard origin/master

## 更新代码到本地
二,更新代码本地到仓库两种方式：

/方法一
$ git fetch origin master //从远程的origin仓库的master分支下载代码到本地的origin master
 
$ git log -p master.. origin/master//比较本地的仓库和远程参考的区别
 
$ git merge origin/master//把远程下载下来的代码合并到本地仓库，远程的和本地的合并
 
//方法二
$ git fetch origin master:temp //从远程的origin仓库的master分支下载到本地并新建一个分支temp
 
$ git diff temp//比较master分支和temp分支的不同
 
$ git merge temp//合并temp分支到master分支
 
$ git branch -d temp//删除temp




