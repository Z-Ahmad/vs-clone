extends CharacterBody2D

signal health_changed(new_health, max_health)
signal died()

@export var max_health: float = 100
var current_health: float

func _ready():
	current_health = max_health
	# If healthbar exists as child, connect the signal
	if has_node("healthbar"):
		health_changed.connect($healthbar.update_health)

func take_damage(amount: float):
	print("took damage: ", amount)
	current_health = max(0, current_health - amount)
	health_changed.emit(current_health, max_health)
	
	if current_health <= 0:
		died.emit()
		queue_free()

func heal(amount: float):
	current_health = min(max_health, current_health + amount)
	health_changed.emit(current_health, max_health) 
