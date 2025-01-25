extends Node2D

var rot = 5;
@export var ORB : PackedScene

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if Input.is_action_just_pressed("shoot"):
		shoot()
	if Input.is_action_pressed("x_rot_neg"):
			rotate(-rot*delta)
	elif Input.is_action_pressed("x_rot_pos"):
			rotate(rot*delta)
	else:
		rotate(0) 
	
	
func shoot():
	print("shooting")
	var orb = ORB.instantiate()
	orb.global_position = get_child(0).global_position
	orb.global_rotation = global_rotation
	var bubble_rune = $"../Inventory".bubble_array[0].rune
	orb.get_child(2).set_texture($"../Inventory".rune_tex[bubble_rune])
	orb.runeID = bubble_rune
	get_node("/root").add_child(orb)
	$"../Inventory".update_stash()

	
	
	
	
	

	# Print the size of the viewport.
