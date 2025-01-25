extends Sprite2D

@export var ruin_tex: Array = []
var bubble_pos = Array()
var size = 3

class bubble:
	var ruin = 0
	var bubble_tex = "res://Sprites/orb.tga"
	var ruin_Tex = Texture2D

var bubble_array = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(3):
		var b = bubble.new()
		b.ruin = randi() % 3
		b.ruin_Tex = ruin_tex[b.ruin]
		bubble_array.append(b)
		
		
		
		
		
		
		
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
