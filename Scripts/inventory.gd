extends Node2D

@export var rune_tex: Array

var size = 5
var tex_size = 3

class bubble:
	var rune = 0
	

var bubble_array = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(size):
		
		var b = bubble.new()
		b.rune = randi() % tex_size
		bubble_array.append(b)
		get_child(i).set_texture(rune_tex[b.rune])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update_stash():
	for i in range(size-1):
		bubble_array[i] = bubble_array[i+1]
		get_child(i).set_texture(rune_tex[bubble_array[i].rune])
	
	bubble_array[size-1] = bubble.new();
	bubble_array[size-1].rune = randi() % tex_size
	get_child(size-1).set_texture(rune_tex[bubble_array[size-1].rune])
	
	
		
		
