extends CharacterBody2D

@export var max_health: float = 100.0
var current_health: float

func _ready():
	current_health = max_health
	$healthbar/TextureProgressBar.max_value = max_health
	$healthbar/TextureProgressBar.value = current_health

func take_damage(damage: float) -> bool:
	current_health = max(current_health - damage, 0)
	$healthbar/TextureProgressBar.value = current_health
	return current_health <= 0 
