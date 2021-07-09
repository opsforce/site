---
title: Thindpad x220 Upgrade the Bluetooth module from 3.0 to 4.0
date: 2021/6/12
---
考虑到手头上的蓝牙设备（鼠标、耳机等）不往下兼容，或者说不支持蓝牙3.0，而且x220这个老本子的蓝牙默认是3.0，所以只能升级x220的蓝牙模块到4.0了。*貌似现在比较新的产品好些都不支持蓝牙3.0*

[购买地址](https://item.taobao.com/item.htm?spm=a1z09.2.0.0.3afc2e8dWwEBsT&id=585334985690&_u=cjnl1al0deb)

罗技鼠标（m590）频繁掉线 -_-

**just `$ sudo pkill bluetoothd`, then daemon bluetooth service will restart self (tested success on macOS 10.14+).**

> Works for me on macOS High Sierra My Logitech mx anywhere does not work after sleep sometimes. As I read its not because of mouse, it's a macOS Smart Bluetooth bug. But my Apple keyboard always works, never got this issue. Sometimes I wake up my computer, the Apple keyboard is working but the Logitech mouse is not working. So without the mouse I cannot restart Bluetooth from the system (I could close but my keyboard also go away, so cannot restart again) I started to use this command from terminal, it stops the service but when the service stops it automatically restarts it self. And my mouse starts working within a second!