extends Sprite2D

@export var rune_tex: Array = []
var bubble_pos = Array()
var size = 3

class bubble:
	var rune = 0
	var rune_Tex = Texture2D

var bubble_array = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(3):
		var b = bubble.new()
		b.rune = randi() % 3
		b.rune_Tex = rune_tex[b.rune]
		bubble_array.append(b)
		
		
		
		
		
		
		
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
