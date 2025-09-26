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
3. That's it! **StatPool** should now be installed.

## Code Reference
### Methods
- `init(min, max, value)` - Initialize with all values
- `increase(amount)` - Add to current value
- `decrease(amount)` - Subtract from current value  
- `fill()` - Set to maximum value
- `deplete()` - Set to minimum value
- `get_percentage()` - Returns 0.0 to 1.0
- `is_filled()` - True if at maximum
- `is_depleted()` - True if at minimum

### Properties
- `value` - Current value (clamped)
- `min_value` - Minimum allowed value
- `max_value` - Maximum allowed value

### Signals
- `value_changed(old_value, new_value, increased)` - When value changes
- `min_value_changed(old_min, new_min, increased)` - When min changes
- `max_value_changed(old_max, new_max, increased)` - When max changes
- `depleted(stat)` - When reaching minimum
- `restored_fully(stat)` - When leaving minimum
- `fully_restored(stat)` - When reaching maximum


## How to Use it
### Basic Health System
```gdscript
# Create a health stat
var health = StatPool.new(0, 100, 80) # min=0, max=100, current=80


## Signal connection
func _ready() -> void:
    health.value_changed.connect(_on_health_changed)
    health.depleted.connect(_on_player_died)
    health.fully_restored.connect(_on_resurrected)


## Example for how to use this plugin
func examples() -> void:
    # Take damage
    health.decrease(25)  
    # Heal
    health.increase(10)
    # 0.65 (65%)
    print(health.get_percentage())


func _on_health_changed(old_value, new_value, increased):
    health_bar.value = health.get_percentage() * 100


func _on_player_died():
    print("Game Over!")


func _on_resurrected():
    print("Respawn player")
```

### Stamina System
```gdscript
var stamina = StatPool.new() # Default start: min=0, max=100, current=100
var running: bool = false


## Drain stamina while running
func _process(delta):
    if Input.is_action_pressed("run") and not stamina.is_depleted():
        running = true
        stamina.decrease(30 * delta)
    else:
        running = false
    
    if not running and not stamina.is_filled():
        stamina.increase(20 * delta)  # Regenerate
```

### Hunger System
```gdscript
var health := StatPool.new() # Default start: min=0, max=100, current=100
var hunger = StatPool.new(0, 100, 50) # min=0, max=100, current=50


## Signal connection
func _ready() -> void:
    hunger.depleted.connect(_on_starving)


## Eat food
func eat_apple():
    hunger.increase(25)


## Will die if is starving
func _on_starving(stat):
    health.deplete()
```

## Support
If this plugin helped you, please, consider:
- ⭐ Star this repository
- 🐛 Report bugs in Issues
- 💡 Suggest improvements


And a BIG thanks to [Nikich](https://github.com/nikoladevelops) for his [godot-plus-plus](https://github.com/nikoladevelops/godot-plus-plus) template.
