extends Sprite2D

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
	orb.global_position = global_position
	orb.global_rotation = global_rotation
	get_node("/root").add_child(orb)

	
	
	
	
	

	# Print the size of the viewport.
