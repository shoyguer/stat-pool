# StatPool - GDNative Plugin for Godot
A simple, efficient stat management system for Godot games. Perfect for health bars, mana pools, stamina systems, hunger meters, or any numeric stat that needs min/max bounds and signal notifications.

## Why Use StatPool?
Managing stats in games is annoying. You always end up writing the same code over and over:
- Clamping values between min/max
- Emitting signals when things change
- Checking if you're at boundaries (empty/full)
- Calculating percentages for UI bars

StatPool handles all of this for you in C++, making it faster and cleaner than doing it in GDScript every time.

___
### WARNING
If you intend to use this plugin with C#, beaware that it will be kinda clunky as of now. I'll soon have it fixed. But for now, you can have a look usage example inside the **How to use it** section.
___


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
- `increase(amount)` - Add `amount` to current `value`
- `decrease(amount)` - Subtract `amount` from current `value ` 
- `fill()` - Set `value` to maximum value
- `deplete()` - Set `value` to minimum value
- `get_percentage()` - Returns percentage of the `value` in relation to `min_value` and `max_value`. Goes from `0.0` to `1.0`
- `is_filled()` - Returns `true` if at maximum. `false` if not.
- `is_depleted()` - Returns `true` if at minimum. `false` if not.

### Properties
- `value` - Current value (limited by `min_value` and `max_value`)
- `min_value` - Minimum allowed `value`
- `max_value` - Maximum allowed `value`

### Signals
- `value_changed(old_value, new_value, increased)` - When value changes
- `min_value_changed(old_min, new_min, increased)` - When min changes
- `max_value_changed(old_max, new_max, increased)` - When max changes
- `depleted(stat)` - When reaching minimum
- `restored_fully(stat)` - When leaving minimum
- `fully_restored(stat)` - When reaching maximum


## How to Use it
### Basic Health System

<details>
<summary><strong>GDScript</strong></summary>

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

</details>

<details>
<summary><strong>C#</strong></summary>

```csharp
using Godot;

public partial class HealthSystem : Node
{
    // Create a health stat
    private Resource health;
    private ProgressBar healthBar; // Assuming you have a health bar UI element
    
    public override void _Ready()
    {
        // Create StatPool with min=0, max=100, current=80
        health = ClassDB.Instantiate("StatPool").As<Resource>();
        health.Set("min_value", 0);
        health.Set("max_value", 100);
        health.Set("value", 80);
        
        // Signal connections
        health.Connect("value_changed", new Callable(this, nameof(OnHealthChanged)));
        health.Connect("depleted", new Callable(this, nameof(OnPlayerDied)));
        health.Connect("fully_restored", new Callable(this, nameof(OnResurrected)));
        
        Examples();
    }
    
    // Example for how to use this plugin
    private void Examples()
    {
        // Take damage
        health.Call("decrease", 25);
        // Heal
        health.Call("increase", 10);
        // 0.65 (65%)
        GD.Print(health.Call("get_percentage"));
    }
    
    private void OnHealthChanged(int oldValue, int newValue, bool increased)
    {
        if (healthBar != null)
            healthBar.Value = health.Call("get_percentage").AsSingle() * 100;
    }
    
    private void OnPlayerDied(Resource stat)
    {
        GD.Print("Game Over!");
    }
    
    private void OnResurrected(Resource stat)
    {
        GD.Print("Respawn player");
    }
}
```

</details>

### Stamina System

<details>
<summary><strong>GDScript</strong></summary>

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

</details>

<details>
<summary><strong>C#</strong></summary>

```csharp
using Godot;

public partial class StaminaSystem : Node
{
    private Resource stamina; // Default start: min=0, max=100, current=100
    private bool running = false;
    
    public override void _Ready()
    {
        // Create default StatPool (min=0, max=100, current=100)
        stamina = ClassDB.Instantiate("StatPool").As<Resource>();
    }
    
    // Drain stamina while running
    public override void _Process(double delta)
    {
        if (Input.IsActionPressed("run") && !stamina.Call("is_depleted").AsBool())
        {
            running = true;
            stamina.Call("decrease", 30 * delta);
        }
        else
        {
            running = false;
        }
        
        if (!running && !stamina.Call("is_filled").AsBool())
        {
            stamina.Call("increase", 20 * delta);  // Regenerate
        }
    }
}
```

</details>

### Hunger System

<details>
<summary><strong>GDScript</strong></summary>

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

</details>

<details>
<summary><strong>C#</strong></summary>

```csharp
using Godot;

public partial class HungerSystem : Node
{
    private Resource health; // Default start: min=0, max=100, current=100
    private Resource hunger; // min=0, max=100, current=50
    
    public override void _Ready()
    {
        // Create default health StatPool (min=0, max=100, current=100)
        health = ClassDB.Instantiate("StatPool").As<Resource>();
        
        // Create hunger StatPool with min=0, max=100, current=50
        hunger = ClassDB.Instantiate("StatPool").As<Resource>();
        hunger.Set("min_value", 0);
        hunger.Set("max_value", 100);
        hunger.Set("value", 50);
        
        // Signal connection
        hunger.Connect("depleted", new Callable(this, nameof(OnStarving)));
    }
    
    // Eat food
    public void EatApple()
    {
        hunger.Call("increase", 25);
    }
    
    // Will die if is starving
    private void OnStarving(Resource stat)
    {
        health.Call("deplete");
    }
}
```

</details>

## Support
If this plugin helped you, please, consider:
- ⭐ Star this repository
- 🐛 Report bugs in Issues
- 💡 Suggest improvements


And a BIG thanks to [Nikich](https://github.com/nikoladevelops) for his [godot-plus-plus](https://github.com/nikoladevelops/godot-plus-plus) template.
