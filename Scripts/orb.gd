extends CharacterBody2D
class_name Orb
@export var speed = 0
var active = true
var collision
@export var connectedOrbs = Array([], TYPE_OBJECT, "Node", Orb)

var runeID
@onready var bubbleSprite = $AnimatedSprite2D




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2(0, -1*speed).rotated(rotation)
	bubbleSprite.play("default")
	
	
			
func _physics_process(delta: float) -> void:
	if active:
		collision = move_and_collide(velocity*delta)
	else: 
		collision = null
	if(collision):
		var colName = collision.get_collider().name
		
			
		if colName == "walls":
			velocity = velocity.bounce(collision.get_normal())
			print("wall")
		elif (collision.get_collider() is Orb):
			connectedOrbs.append(collision.get_collider())
			collision.get_collider().connectedOrbs.append(self)
			velocity = Vector2.ZERO
			process_mode = 4
			active = false
			print("orb")
		elif (collision.get_collider() is Seal):
			collision.get_collider().connectedOrbs.append(self)
			collision.get_collider()._testSeal()
			velocity = Vector2.ZERO
			process_mode = 4
			active = false
			print("seal")
		else:
			velocity = Vector2.ZERO
			process_mode = 4
			active = false
		
	
	
	
	
