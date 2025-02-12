extends Node2D

@export var max_health: float = 100.0
var current_health: float = max_health

# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureProgressBar.value = current_health

func take_damage(damage: float) -> bool:
	current_health = max(current_health - damage, 0)
	$TextureProgressBar.value = current_health
	return current_health <= 0 
