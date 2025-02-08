extends Node2D

#
# Called every frame. 'delta' is the elapsed time since the previous frame.
func bubbleshit(ORB):
	for i in 4:
		await get_tree().create_timer(.25).timeout
		print("Bub")
		var orb = ORB.instantiate()
		orb.global_position = self.global_position + Vector2(randf_range(-2, 2), randf_range(-2, 2))
		orb.global_rotation = randf()
		var bubble_rune = randi() % 3
		orb.get_child(1).set_texture($"../Inventory".rune_tex[bubble_rune])
		orb.runeID = bubble_rune
		orb.speed = 1000
		get_node("/root/Root").add_child(orb)
		
		
