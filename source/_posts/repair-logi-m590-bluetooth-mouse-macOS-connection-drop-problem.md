---
title: 不完美的解决方案：macOS 连接 logi m590 蓝牙鼠标时常出现掉线问题
date: 2021/8/30
categories:
- bluetooth
- macos
- logi
---

macOS 蓝牙连接logi设备是，时不时出现掉线问题，令人很烦恼，在网上查了一通，很多人说是macOS的bug，自己也尝试了一通，写了一通脚本等等，最终临时得出来一个不完美的解决方案：**模拟手动打开 System Preferences - Bluetooth，这样就可以让系统重新/再次扫描可连接蓝牙设备，前台窗框打开3～5秒后，再关闭 System Preferences 窗口，会发现鼠标又已经重新连接上了**

放上（半）自动化此方案的相关资源/操作：

依赖：
- [blueutil](https://github.com/toy/blueutil)
- launchctl (macOS 自带)

launchd 服务（.plist)文件路径：`~/Library/LaunchAgents/repair.logi.m590.bluetooth.mouse.macOS.connection.drop.problem.plist`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <!-- Label唯一的标识 -->
    <key>Label</key>
    <string>repair.logi.m590.bluetooth.mouse.macOS.connection.drop.problem</string>
    <!-- 指定要运行的脚本 -->
    <key>ProgramArguments</key>
    <array>
        <!-- 下面脚本的绝对路径，记得修改 -->
        <string>/Users/username/repair.logi.m590.bluetooth.mouse.macOS.connection.drop.problem.sh</string>
    </array>
    <!-- 每5秒会运行一次，可自行更改 -->
    <key>StartInterval</key>
    <integer>5</integer>
    <!-- 脚本运行的日志，可自行更改/放开 -->
    <!-- <key>StandardErrorPath</key> -->
    <!-- <string>/var/log/repair.logi.m590.bluetooth.mouse.macOS.connection.drop.problem.log</string> -->
    <!-- <key>StandardOutPath</key> -->
    <!-- <string>/var/log/repair.logi.m590.bluetooth.mouse.macOS.connection.drop.problem.log</string> -->
</dict>
</plist>
```

脚本：`repair.logi.m590.bluetooth.mouse.macOS.connection.drop.problem.sh`

```bash
#!/bin/sh

# M585/M590: f3-7a-db-1f-18-86

#export BLUEUTIL_ALLOW_ROOT=1
CONNECT_STATUS=$(/usr/local/bin/blueutil --is-connected f3-7a-db-1f-18-86)

NOTIFY_TITLE="Repair macOS Bluetooth connection drop problem"

BLUETOOTHD_PPID=$(ps aux | grep bluetoothd | grep -v grep | awk '{print $2}')

if [[ "${CONNECT_STATUS}" == "0" ]]; then
    # /usr/local/bin/blueutil --inquiry

    open /System/Library/PreferencePanes/Bluetooth.prefPane

    CONNECT_STATUS_NEW=$(/usr/local/bin/blueutil --is-connected f3-7a-db-1f-18-86)

    if [[ "${CONNECT_STATUS_NEW}" == "1" ]]; then
        NOTIFY_CONTENT="Logi m590 Bluetooth mouse maybe reconnected"
        osascript -e "display notification \"${NOTIFY_CONTENT}\" with title \"${NOTIFY_TITLE}\""

    # else
    #     NOTIFY_CONTENT="Logi m590 Bluetooth mouse reconnect fail, will handle it by killing bluetoothd process, please wait a moment"
    #     osascript -e "display notification \"${NOTIFY_CONTENT}\" with title \"${NOTIFY_TITLE}\""

    #     /usr/bin/pkill bluetoothd
    #     # sleep 1
    #     BLUETOOTHD_PID=$(ps aux | grep bluetoothd | grep -v grep | awk '{print $2}')

    #     if [[ ${BLUETOOTHD_PID} == ${BLUETOOTHD_PPID} ]]; then
    #         NOTIFY_CONTENT="Kill bluetoothd process[ pid: ${BLUETOOTHD_PPID} ] fail, please handle it manually"
    #     else
    #         NOTIFY_CONTENT="Logi m590 Bluetooth mouse maybe reconnected. bluetoothd process[ pid: ${BLUETOOTHD_PPID}->${BLUETOOTHD_PID} ]"
    #     fi
    fi

#    sleep 10
#    # 如果和其它类似操作同步的话，会中断其它操作，暂时先常驻非显现窗口
#    osascript -e 'tell application "System Preferences" to quit'
fi

```

最后启动 launchd 服务：

```
$ chmod 644 ~/Library/LaunchAgents/repair.logi.m590.bluetooth.mouse.macOS.connection.drop.problem.plist
$ chmod 755 repair.logi.m590.bluetooth.mouse.macOS.connection.drop.problem.sh
$ launchctl load -w ~/Library/LaunchAgents/repair.logi.m590.bluetooth.mouse.macOS.connection.drop.problem.plist
```
