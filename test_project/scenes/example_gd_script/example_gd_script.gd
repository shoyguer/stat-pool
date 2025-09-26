extends Node2D
## Test scene for StatPool functionality demonstration.


## StatPool instance for testing operations.
@export var stat_pool: StatPool = null


## Runs StatPool tests and creates health example.
func _ready() -> void:
	connect_signals()
	run_tests()
	create_health_example()


## Connects StatPool signals.
func connect_signals() -> void:
	stat_pool.value_changed.connect(_on_value_changed)
	stat_pool.depleted.connect(_on_depleted)
	stat_pool.restored.connect(_on_restored)
	stat_pool.restored_fully.connect(_on_restored_fully)


## Runs comprehensive StatPool tests.
func run_tests() -> void:
	print("StatPool Test Suite")
	print_status("Initial state")
	
	print("\nTesting value modifications...")
	stat_pool.decrease(30)
	print_status("After decreasing by %d" % 30)
	
	stat_pool.increase(15)
	print_status("After increasing by %d" % 15)
	
	print("\nTesting boundaries...")
	stat_pool.deplete()
	print_status("After deplete()")
	
	stat_pool.increase(25)
	print_status("After restoring by %d" % 25)
	
	stat_pool.fill()
	print_status("After fill()")
	
	print("\nTesting range changes...")
	stat_pool.set_max_value(150)
	print_status("Max changed to 150")
	
	print("\nTESTS COMPLETED!")


## Creates health stat example.
func create_health_example() -> void:
	var health := StatPool.new()
	health.min_value = 0
	health.max_value = 200
	health.value = 150
	
	print("\nHealth example: %d/%d HP" % [health.get_value(), health.get_max_value()])
	print(health.get_min_value())
	print(health.get_max_value())
	health.set_max_value(150)
	print(health.get_max_value())


## Prints current StatPool status.
func print_status(label: String) -> void:
	var current = stat_pool.get_value()
	var percentage = stat_pool.get_percentage() * 100
	var status = ""
	
	if stat_pool.is_depleted():
		status = "EMPTY"
	elif stat_pool.is_filled():
		status = "FULL"
	else:
		status = "PARTIAL"
	
	print("  %s: %d (%.0f%%) [%s]" % [label, current, percentage, status])


#region Signal Handlers
## Handles value changes.
func _on_value_changed(old_value: int, new_value: int, increased: bool) -> void:
	var direction = "↑" if increased else "↓"
	var change = abs(new_value - old_value)
	print("  %s Value changed by %d: %d → %d" % [direction, change, old_value, new_value])


## Handles stat depletion.
func _on_depleted(_stat: StatPool) -> void:
	print("Stat depleted!")


## Handles restoration from minimum.
func _on_restored(_stat: StatPool) -> void:
	print("Restored from empty!")


## Handles full restoration.
func _on_restored_fully(_stat: StatPool) -> void:
	print("Fully restored!")
#endregion
