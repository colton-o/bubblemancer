extends CharacterBody2D
class_name Orb
@export var speed = 0
var active = true
var collision
var connectedOrbs = Array([], TYPE_OBJECT, "Node", Orb)
var runeID;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2(0, -1*speed).rotated(rotation)
	


	
			
func _physics_process(delta: float) -> void:
	if active:
		collision = move_and_collide(velocity*delta)
	else: 
		collision = null
	if(collision):
		var colName = collision.get_collider().name
		print(colName)
		if colName == "walls":
			velocity = velocity.bounce(collision.get_normal())
			print("wall")
		elif colName == "orb":
			connectedOrbs.append(collision)
			collision.connectedOrbs.append(self)
			velocity = Vector2.ZERO
			process_mode = 4
			active = false
			print("orb")
		else:
			velocity = Vector2.ZERO
			process_mode = 4
			active = false
		
	
	
	
	
