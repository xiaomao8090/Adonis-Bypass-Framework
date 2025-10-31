# Adonis Bypass Framework

Multi-layer bypass for AdonisAC in Roblox.

多层级 AdonisAC 绕过框架。

**Version:** v1.0.2  
**Author:** xiaomao  
**QQ:** 1303323893  
**QQ Group:** 154919631

---

## Features / 功能

- Remote interception with pattern matching / 远程拦截与模式匹配
- Multi-layer kick protection / 多层踢出保护
- Detected function hook / 检测函数钩子
- Call stack spoofing / 调用栈伪装
- GetGC rate limiting / GetGC 速率限制
- GUI detection blocking / GUI 检测拦截
- Behavior randomization / 行为随机化

## Installation / 安装

Just paste this in your executor:

在你的执行器中粘贴以下代码：

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaomao8090/Adonis-Bypass-Framework/master/AdonisBypass.lua"))()
```

Or download `AdonisBypass.lua` and execute it directly.

或者下载 `AdonisBypass.lua` 文件直接执行。

## Config / 配置

```lua
local CONFIG = {
    DELAY = 12,              -- 等待时间
    HIDE_CONSOLE = false,    -- 隐藏控制台
    FAKE_LAG = true,         -- 模拟延迟
    BEHAVIOR_RANDOM = true,  -- 行为随机化
    BLOCK_REMOTES = true,    -- 拦截远程事件
}
```

## Usage / 使用方法

Execute the script before AdonisAC loads. Check console for progress messages.

在 AdonisAC 加载前执行脚本。查看控制台获取进度信息。

Layer 13 waits 5 seconds for Adonis to fully load before hooking.

第 13 层会等待 5 秒确保 Adonis 完全加载后再进行钩子操作。

## Issues / 问题排查

If bypass fails / 如果绕过失败：
- Make sure you're using a compatible executor / 确保使用兼容的执行器
- Try reloading the script / 尝试重新加载脚本
- Check console for errors / 检查控制台错误信息

If script crashes / 如果脚本崩溃：
- Some executors don't support all features / 某些执行器不支持所有功能
- Try disabling layers in CONFIG / 尝试在 CONFIG 中禁用某些层

## Support / 支持

QQ Group: 154919631

## Changelog / 更新日志

**v1.0.2**
- Enhanced remote interception / 增强远程拦截
- Multi-layer kick protection / 多层踢出保护
- Added call stack spoofing / 添加调用栈伪装
- Improved Detected hook / 改进检测钩子
- Better error handling / 更好的错误处理

**v1.0.1**
- Improved remote parameter modification / 改进远程参数修改
- Better compatibility / 更好的兼容性

**v1.0.0**
- Initial release / 初始版本

## Credits / 致谢

External bypass from Jko-Scripts/Adonis-AC-Bypass

外部绕过代码来自 Jko-Scripts/Adonis-AC-Bypass

