@tool
class_name Stat
extends Resource
## Generic stat management component.
## 
## Base component for tracking any numeric stat with minimum and maximum values.
## Handles stat modifications, boundary management, and emits signals for value changes.
## Can be extended for specific stat types like Health, Hunger, Mood, etc.


## Signal emitted when the maximum stat value changes.
signal max_value_changed(old_max: int, new_max: int, increased: bool)
## Signal emitted when the current stat value changes.
signal value_changed(old_value: int, new_value: int, increased: bool)
## Signal emitted when stat reaches minimum value (typically zero).
signal depleted(stat: Stat)
## Signal emitted when stat is restored from minimum value.
signal restored(stat: Stat)
## Signal emitted when stat reaches maximum value.
signal fully_restored(stat: Stat)

## Maximum possible stat value.
@export var max_value: int = 100: set = set_max_value
## Current stat value.
@export var value: int = 100: set = set_value

#region Properties
## Returns true if the stat is at its minimum value.
var is_at_minimum: bool:
	get:
		return value == 0

## Returns true if the stat is at its maximum value.
var is_at_maximum: bool:
	get:
		return value == max_value

## Returns the stat value as a percentage (0.0 to 1.0).
var percentage: float:
	get:
		if max_value == 0:
			return 1.0
		return float(value) / float(max_value)
#endregion


## Initializes the Stat with a specific maximum value.
## [param new_max]: The maximum value to set.
func init(new_max: int) -> void:
	resource_local_to_scene = true

	set_max_value(new_max)
	set_to_maximum()


#region Value Management
## Sets the maximum stat value.
## [param new_max]: The new maximum value to set.
func set_max_value(new_max: int) -> void:
	if new_max == max_value: return
	
	var old_max = max_value
	max_value = new_max
	
	# Clamp current value to new maximum
	if value > max_value:
		set_value(max_value)
	
	max_value_changed.emit(old_max, max_value, max_value > old_max)


## Sets the current stat value.
## [param new_value]: The new value to set.
func set_value(new_value: int) -> void:
	if new_value == value: return
	
	var old_value = value
	value = clampi(new_value, 0, max_value)
	
	value_changed.emit(old_value, value, value > old_value)
	
	# Emit boundary signals
	if value == 0 and old_value != 0:
		depleted.emit(self)
	elif value > 0 and old_value == 0:
		restored.emit(self)
	elif value == max_value and old_value != max_value:
		fully_restored.emit(self)


## Increases the stat value by the specified amount.
## [param amount]: Amount to increase the stat by.
func increase(amount: int) -> void:
	set_value(value + amount)


## Decreases the stat value by the specified amount.
## [param amount]: Amount to decrease the stat by.
func decrease(amount: int) -> void:
	set_value(value - amount)


## Sets the stat to its maximum value.
func set_to_maximum() -> void:
	set_value(max_value)


## Sets the stat to its minimum value.
func set_to_minimum() -> void:
	set_value(0)
#endregion
