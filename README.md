# StatPool - GDNative Plugin for Godot
A simple, efficient stat management system for Godot games. Perfect for health bars, mana pools, stamina systems, hunger meters, or any numeric stat that needs min/max bounds and signal notifications.

## Why Use StatPool?
Managing stats in games is annoying. You always end up writing the same code over and over:
- Clamping values between min/max
- Emitting signals when things change
- Checking if you're at boundaries (empty/full)
- Calculating percentages for UI bars

StatPool handles all of this for you in C++, making it faster and cleaner than doing it in GDScript every time.

## Why C++ Instead of GDScript?
Simple - performance. If you have 100+ enemies each with health/mana/stamina stats, that's 300+ StatPools that need to be managed. C++ handles this way better than GDScript.

(Also because I did this plugin to challange myself, since it's been a good 8 years since the last time I coded anything C++ related.)

## Requirements
- Godot 4.3+ (might work on earlier versions, I haven't tested)

## Building From Source
Only needed if you want to modify the plugin.
Follow [godot-plus-plus](https://github.com/nikoladevelops/godot-plus-plus/tree/main) instructions, and you'll be fine!

## Installation
1. Download the latest release
2. Extract to your Godot project - I strongly recommend you place this plugin folder inside your project's 'addon' folder:
**your_project_folder > addons > stat_pool**
3. That's it! **StatPool** should now be installed :grin:.

## How to use StatPool
Check the [Wiki](https://github.com/shoyguer/stat-pool/wiki) for information on how to use this plugin.

#### Class reference
- [Class Reference](https://github.com/shoyguer/stat-pool/wiki/1.-Class-Reference)

#### Usage Examples
- [GDScript](https://github.com/shoyguer/stat-pool/wiki/2.1.-GDScript-Code-Example)
- [C#](https://github.com/shoyguer/stat-pool/wiki/2.2.-C%23-code-example)

## Support
If this plugin helped you, please, consider:
- ⭐ Star this repository
- 🐛 Report bugs in Issues
- 💡 Suggest improvements


And a BIG thanks to [Nikich](https://github.com/nikoladevelops) for his [godot-plus-plus](https://github.com/nikoladevelops/godot-plus-plus) template.
