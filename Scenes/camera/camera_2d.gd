extends Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	make_current() # make current camera


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var target_position = acquire_target()
	global_position = global_position.lerp(target_position, 1.0 - exp(-delta * 10))
	

func acquire_target():
	var player_nodes = get_tree().get_nodes_in_group("player")
	if player_nodes.size() > 0:
		var player = player_nodes[0] as Node2D
		return player.global_position
