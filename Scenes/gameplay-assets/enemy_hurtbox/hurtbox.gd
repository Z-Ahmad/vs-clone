extends Area2D

var poof_scene = preload("res://Scenes/enemies/effects/death-poof.tscn")

func _ready():
	area_entered.connect(on_area_entered)
	
func on_area_entered(area: Area2D):
	if area.get_parent().is_in_group("attack"):
		var enemy = get_parent()
		
		if enemy.get_node("healthbar").take_damage(50):  # 20 damage per hit
			var poof = poof_scene.instantiate()
			enemy.get_tree().current_scene.add_child(poof)
			poof.global_position = enemy.global_position
			enemy.queue_free()
