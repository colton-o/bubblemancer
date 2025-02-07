extends Node2D

var rot = 1
var turns = 10
var xAxis = 0
@export var ORB : PackedScene
@export var shoot_fx : Array[AudioStream]

func _ready() -> void:
	$"../UI/Turn".text = "Turns: %s" % turns


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if Input.is_action_just_pressed("shoot"):
		shoot()
	rotate(xAxis * rot * delta)
	
	if(transform.get_rotation() > 1):
		rotation = 1
	if(transform.get_rotation() < -1):
		rotation = -1

	
	xAxis = 0
	
	
func shoot():
	$"../SFX".set_stream(shoot_fx[randi() %3])
	$"../SFX".play()
	$Sprite.play("Shoot")
	print("shooting")
	var orb = ORB.instantiate()
	orb.global_position = get_child(0).global_position
	orb.global_rotation = global_rotation
	var bubble_rune = $"../Inventory".bubble_array[0].rune
	orb.get_child(1).set_texture($"../Inventory".rune_tex[bubble_rune])
	orb.runeID = bubble_rune
	get_node("/root/Root").add_child(orb)
	$"../Inventory".update_stash()
	turns -= 1
	$"../UI/Turn".text = "Turns: %s" % turns
	if(turns < 0):
		get_tree().reload_current_scene()
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		xAxis = event.relative.x


	
	
	
	
	
	
