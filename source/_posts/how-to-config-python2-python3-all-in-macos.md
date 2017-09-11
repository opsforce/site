---
title: Mac下配置Python2和Python3共存
date: 2016/7/10 20:46:25
updated: 2016/7/13 20:46:25
categories:
- Develop
tags:
- Mac
- Python
- Virtualenv
---
Mac默认是安装了Python2的，所以只需要安装Python3
```
brew install python3 # 使用homebrew安装python3
sudo easy_install virtualenv # 安装virtualenv
mkdir Workspace &&　cd Workspace　# 创建本地工作目录
which python3 # 找出Python3路径

# python2
virtualenv --no-site-packages venv # 配置Python2虚拟路径
source venv/bin/activate # 使Python2虚拟路径生效
deactivate # 使Python2虚拟路径失效

# python3
virtualenv --no-site-packages --python=/usr/local/bin/python3 venv3 # 配置Python3虚拟路径
source venv3/bin/activate # 使Python3虚拟路径生效
deactivate # 使Python3虚拟路径失效
```
