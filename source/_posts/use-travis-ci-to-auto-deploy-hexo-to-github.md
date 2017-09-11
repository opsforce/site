---
title: 使用 Travis CI 自动部署 Hexo
date: 2017/7/13 20:46:25
updated: 2017/7/13 20:46:25
categories:
- CICD
tags:
- github
- TravisCI
---
鉴于使用Hexo部署网站的繁琐性，便利用软件开发中的持续集成工具Travis CI来帮助完成这一繁杂过程。

Travis CI

CI是Continuous Integration的缩写，持续集成之意。

持续集成是一种软件开发实践，每次集成都通过自动化的构建（包括编译，发布，自动化测试）来验证，从而尽早地发现集成错误。

Continuous Integration
Travis CI 是目前新兴的开源持续集成构建项目，用来构建托管在GitHub上的代码。它提供了多种编程语言的支持，包括Ruby，JavaScript，Java，Scala，PHP，Haskell和Erlang在内的多种语言。许多知名的开源项目使用它来在每次提交的时候进行构建测试，比如Ruby on Rails，Ruby和Node.js。

Travis CI是在软件开发领域中的一个在线的，分布式的持续集成服务，用来构建及测试在GitHub托管的代码。这个软件的代码同时也是开源的，可以在GitHub上下载到，尽管开发者当前并不推荐在闭源项目中单独使用它。
工作原理

当我们每次进行push等动作时，Travis CI 会自动检测我们的提交，然后根据配置文件，搭建虚拟主机来运行测试，构建等指令。在这里，就是运行hexo g d等命令来自动生成、部署静态网页。


Travis CI
Travis CI 官方文档：https://docs.travis-ci.com/

具体配置

Hexo 搭建

这里使用Hexo+Next+GitHub Pages组合示范过程，具体过程不再赘述。网站源码放到Hexo分支，博客的静态文件部署到master分支。


hexo源代码
设置 Travis CI

登陆 Travis CI，使用 GitHub 账户登录，它会自动关联 GitHub 上的仓库。点击右上角用户查看 GitHub 仓库，并选择要启动的项目，这里选择yourname/yourname.github.io。

点击设置按钮，进入设置选项，开启相关服务，Build only if .travis.yml is present：指只在有.travis.yml时改变了才构建；Build pushes：push 完分支后开始构建。


设置
访问仓库是需要权限的，下面配置权限信息。

配置 Acess Token

登陆GitHub，进入设置界面，在Personal access tokens页面下点击右上角的Generate new token按钮会生成新的token，随后输入密码，取个名字，勾选一些权限


Personal access tokens
拷贝 token 并在 Travis CI 页面中配置Environment Variables。


Environment Variables
Travis CI 已获得仓库权限，现在可以给它相关操作指令了。

配置 .travis.yml

.travis.yml 内容如下：
```
language: node_js  #设置语言

node_js: stable  #设置相应的版本

install:
  - npm install  #安装hexo及插件

script:
  - hexo cl  #清除
  - hexo g  #生成

after_script:
  - cd ./public
  - git init
  - git config user.name "yourname"  #修改name
  - git config user.email "your email"  #修改email
  - git add .
  - git commit -m "update"
  - git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" master:master  #GH_TOKEN是在Travis中配置token的名称

branches:
  only:
    - hexo  #只监测hexo分支，hexo是我的分支的名称，可根据自己情况设置
env:
 global:
   - GH_REF: github.com/yourname/yourname.github.io.git  #设置GH_REF，注意更改yourname
```   
.travis.yml 配置完成后，还需要注意一个问题，即 Travis 在创建虚拟机后，如何利用npm install安装 Hexo 及其依赖文件。进行过本地部署的话就不难发现，我们所需要的依赖文件会自动添加到 package.json 列表中，因此 package.json 文件不可少。


package.json
配置Hexo时还会生成node_modules文件夹，这是 Hexo 及其依赖包的位置，它和 package.json 文件列表是对应的。因此 node_modules 文件夹不需要 push 远程仓库，CI平台的虚拟机会自己创建的。

另外注意这些文件的格式，尤其是.yml的格式，稍有偏差就有可能出问题。

Push 到 GitHub

在_posts目录下新建文章并 push 分支，登陆 Travis CI 即可发现已经检测到分支变化并开始构建，其中job log记录了构建的过程。


hexo deployer
自动部署完成，打开网页查看效果


post
参考资料

Hexo 自动部署到 Github
手把手教你使用Travis CI自动部署你的Hexo博客到Github上
使用 travis-ci 自动部署 hexo 博客