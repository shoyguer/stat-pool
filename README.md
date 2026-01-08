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
2. Extract to your Godot project, and make sure this is how your project structure looks:
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

#### Wiki
- [Class Reference](https://github.com/shoyguer/stat-pool/wiki/1.-Class-Reference)
- [Code Examples](https://github.com/shoyguer/stat-pool/wiki/2.1.-GDScript-Code-Example)

## Other Plugins
Check out my other Godot plugins:

| Plugin | Description |
|--------|-------------|
| [<img src="https://raw.githubusercontent.com/shoyguer/seed/refs/heads/main/brand/header_image.png" width="192">](https://github.com/shoyguer/seed) | Seed generation system |
| [<img src="https://raw.githubusercontent.com/shoyguer/time-tick/refs/heads/main/brand/header_image.png" width="192">](https://github.com/shoyguer/time-tick) | Flexible time management system |
| [<img src="https://raw.githubusercontent.com/shoyguer/advanced-button/refs/heads/main/src/brand/header_image.png" width="192">](https://github.com/shoyguer/advanced-button) | Complete and Customizeable button with useful features |


## Support
If this plugin helped you, please, consider:
- ⭐ Star this repository
- 🐛 Report bugs in Issues
- 💡 Suggest improvements

___

And a BIG thanks to [Nikich](https://github.com/nikoladevelops) for his [godot-plus-plus](https://github.com/nikoladevelops/godot-plus-plus) template.
