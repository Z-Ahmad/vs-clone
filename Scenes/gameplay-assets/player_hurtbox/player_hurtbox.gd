extends Area2D

var poof_scene = preload("res://Scenes/enemies/effects/death-poof.tscn")

func _ready():
	area_entered.connect(on_area_entered)
	
func on_area_entered(area: Area2D):
	print(area)
	if area.get_parent().is_in_group("enemy"):
		print("enemy entered!")
		var player = get_parent()
		
		if player.get_node("healthbar").take_damage(10): 
			var poof = poof_scene.instantiate()
			player.get_tree().current_scene.add_child(poof)
			poof.global_position = player.global_position
			player.queue_free()
