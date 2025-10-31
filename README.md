# Adonis Bypass Framework

A comprehensive multi-layered anti-cheat bypass framework for AdonisAC in Roblox.

**Version:** v1.0.2  
**Author:** xiaomao  
**QQ Group:** 154919631

## ⚠️ Disclaimer

This project is for educational and research purposes only. The use of bypass scripts may violate Roblox's Terms of Service. Use at your own risk.

## 📋 Features

This framework implements multiple layers of protection against AdonisAC detection:

- **Layer 1: Core Bypass Module** - Embedded bypass that hooks critical AdonisAC functions (currently disabled)
- **Layer 2: Smart Delay System** - Waits for anti-cheat initialization before activation
- **Layer 3: Metatable Protection** - Protects game metatables from detection
- **Layer 4: Enhanced Remote Interception** - Blocks suspicious remote events with pattern matching and multi-layer kick protection
- **Layer 5: Behavior Randomization** - Randomizes player behavior to avoid pattern detection
- **Layer 6: Exploit Trace Hiding** - Removes common exploit identifiers
- **Layer 8: Fake Lag System** - Simulates network latency patterns
- **Layer 9: Safe GetGC Wrapper** - Limits garbage collector access frequency with rate limiting
- **Layer 10: GUI Detection Blocking** - Intercepts and blocks detection GUI elements
- **Layer 11: Call Stack Spoofing** - Masks external script call origins to avoid detection
- **Layer 13: Enhanced Detected Hook** - Hooks AdonisAC's Detected function with improved safety and stability

## 📦 Installation

### Direct Download

**Raw Script Link (Copy this URL into your executor):**
```
https://raw.githubusercontent.com/xiaomao8090/Adonis-Bypass-Framework/master/AdonisBypass.lua
```

Or use this format in Lua:
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaomao8090/Adonis-Bypass-Framework/master/AdonisBypass.lua"))()
```

### Manual Installation

1. Download the script file (`AdonisBypass.lua`)
2. Execute in your Roblox executor
3. Wait for the bypass framework to load
4. Check console for loading progress messages

## 🔧 Configuration

The script includes a configurable `CONFIG` table:

```lua
local CONFIG = {
    DELAY = 12,              -- Wait time for anti-cheat initialization
    HIDE_CONSOLE = false,    -- Hide console output
    FAKE_LAG = true,         -- Enable fake lag simulation
    BEHAVIOR_RANDOM = true,  -- Enable behavior randomization
    BLOCK_REMOTES = true,    -- Enable remote interception
}
```

## ⚙️ Usage

Simply execute the script in your Roblox executor. The script will:

1. Wait for game to fully load
2. Initialize all bypass layers sequentially
3. Display progress messages in console
4. Complete bypass setup automatically

## 📝 Important Notes

- The framework must be loaded before AdonisAC fully initializes
- Some layers may take time to activate - be patient during the loading process
- Layer 13 (Detected Hook) waits 5 seconds for Adonis to fully load before attempting hook
- Layer 9 (GetGC Wrapper) limits calls to prevent detection
- If bypass fails, check your executor's compatibility and support for required functions
- This script is designed for educational purposes - use responsibly

## 🐛 Troubleshooting

### Bypass Fails
- Try reloading the script
- Ensure you're using a compatible executor
- Check console for error messages

### Script Crashes
- Some executors may not support all features
- Try disabling certain layers in CONFIG

## 📞 Support

For support, questions, or updates:

- **QQ Group:** 154919631
- **Author:** xiaomao

## 🔒 Security Notice

This script uses multiple layers of protection to avoid detection. All layers are implemented with proper error handling and safety checks.

For questions, support, or updates, please join our QQ group: **154919631**

## 📄 License

This project is provided as-is for educational purposes. No warranty is provided.

## 🔄 Version History

### v1.0.2
- Enhanced Remote interception with suspicious pattern matching
- Multi-layer Kick protection (3 methods)
- Enabled safe GetGC wrapper with rate limiting
- Added call stack spoofing (Layer 11)
- Enhanced Detected Hook with improved safety (Layer 13)
- Improved error handling across all layers
- Better stability and performance optimizations

### v1.0.1
- Improved Remote parameter modification
- Enhanced error handling
- Better compatibility with different executors

### v1.0.0
- Initial release
- Multi-layered bypass system
- Comprehensive protection mechanisms

## 🙏 Credits

- **External Bypass:** Jko-Scripts/Adonis-AC-Bypass
- **Framework Design:** xiaomao

---

**Remember:** This tool is for educational purposes. Always respect game rules and terms of service.

