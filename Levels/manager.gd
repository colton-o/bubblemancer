extends Node2D
@export var target_score : int
@export var level : int
var current_score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(current_score == target_score):
		var scene = "res://Levels/Stage_%s.tscn" % (level+1)
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file(scene)
		
		
