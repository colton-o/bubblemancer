extends Node2D

var rot = 1
var turns = 5
var xAxis = 0
@export var ORB : PackedScene
@export var shoot_fx : Array[AudioStream]
var can_shoot

func _ready() -> void:
	$"../UI/Turn".text = "Turns: %s" % turns
	can_shoot = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if Input.is_action_just_pressed("shoot"):
		if can_shoot == true:
				shoot(3)
	rotate(xAxis * rot * delta)
	
	if(transform.get_rotation() > 1):
		rotation = 1
	if(transform.get_rotation() < -1):
		rotation = -1

	
	xAxis = 0
	
		
func shoot(numBubbles: int):
	print("shooting")
	turns -= 1
	$"../UI/Turn".text = "Turns: %s" % turns
	
	for i in numBubbles:
		$"../Inventory/AnimationPlayer".play("RESET")
		$"../SFX".set_stream(shoot_fx[randi() %3])
		$"../SFX".play()
		$Sprite.play("Shoot")
		var orb = ORB.instantiate()
		orb.global_position = get_child(0).global_position
		orb.global_rotation = global_rotation
		var bubble_rune = $"../Inventory".bubble_array[0].rune
		orb.get_child(1).set_texture($"../Inventory".rune_tex[bubble_rune])
		orb.runeID = bubble_rune
		get_node("/root/Root").add_child(orb)
		$"../Inventory".update_stash()
		$"../Inventory/AnimationPlayer".play("Move_runes")
		await get_tree().create_timer(.1).timeout
	
	if(turns == 0):
		can_shoot = false
		$"../UI".get_child(1).visible = true
		
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		xAxis = event.relative.x


	
	
	
	
	
	
