extends Camera2D

var last_known_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	make_current() # make current camera
	# Store initial position in case player dies immediately
	var target = acquire_target()
	if target:
		last_known_position = target


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var target_position = acquire_target()
	if target_position:
		last_known_position = target_position
		global_position = global_position.lerp(target_position, 1.0 - exp(-delta * 10))
	else:
		# If no player (dead), stay at last known position
		global_position = global_position.lerp(last_known_position, 1.0 - exp(-delta * 10))

func acquire_target():
	var player_nodes = get_tree().get_nodes_in_group("player")
	if player_nodes.size() > 0:
		var player = player_nodes[0] as Node2D
		return player.global_position
	return null  # Return null if no player found
