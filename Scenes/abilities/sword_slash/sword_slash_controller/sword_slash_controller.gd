extends Node2D

@export var sword_ability: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
#	run on_timer_timeout whenever the timer runs out
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return

	var sword_instance = sword_ability.instantiate() as Node2D
	player.add_child(sword_instance)
