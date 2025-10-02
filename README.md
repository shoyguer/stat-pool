# StatPool
A simple, efficient stat management system for Godot games. Perfect to be used for health, mana pools, stamina systems, hunger meters, or any numeric stat that needs min/max bounds and signal notifications.

![Header Image](https://raw.githubusercontent.com/shoyguer/stat-pool/refs/heads/main/brand/header_image.png)

## Why Use StatPool?
Managing stats in games is annoying. You always end up writing the same code over and over:
- Clamping values between min/max
- Emitting signals when things change
- Checking if you're at boundaries (empty/full)
- Calculating percentages for UI bars

This is a GDExtension plugin, this means it was done with performance in mind.

### Target platforms:
| Platform | Supported Systems |
|----------|------------------|
| **Desktop** | 🪟 Windows • 🐧 Linux • 🍎 MacOS |
| **Mobile** | 🤖 Android • 📱 iOS |
| **Others** | 🌐 Web |

## Requirements
- [Godot 4.5](https://godotengine.org/)

## Building From Source
Only needed if you want to modify the plugin.
Follow [godot-plus-plus](https://github.com/nikoladevelops/godot-plus-plus/tree/main) instructions, and you'll be fine!

## Installation
1. Download the latest release
2. Extract to your Godot project - I strongly recommend you place this plugin folder inside your project's 'addon' folder:
```
your_project_folder/
├── addons/
│   └── stat_pool/
│       ├── bin/
│       ├── stat_pool.gdextension
│       └── ...
```
3. That's it! **StatPool** should now be installed :grin:.

(Since it is a GDExtension plugin, you don't need to activate it through Project Settings)

## How to use StatPool
Check the [Wiki](https://github.com/shoyguer/stat-pool/wiki) for information on how to use this plugin.

Or jump to whatever you need:

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

___

And a BIG thanks to [Nikich](https://github.com/nikoladevelops) for his [godot-plus-plus](https://github.com/nikoladevelops/godot-plus-plus) template.
