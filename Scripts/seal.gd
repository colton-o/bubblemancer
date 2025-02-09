extends StaticBody2D

class_name Seal
var requiredRunes: Array[int] = [0,0,0]

@export var rune_tex_array : Array

var tex_num : Array[int] = [10,10,10]

@export var connectedOrbs = Array([], TYPE_OBJECT, "Node", Orb)

# Old audio implemnentation
#@export var break_sfx : AudioStream

@onready var rune_activated_sfx = $RuneActivated
@onready var orb_break_sfx = $OrbBreak

var alive = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(len(requiredRunes)):
		requiredRunes[i] = randi() % 3;
		var temp = requiredRunes[i]*3  + randi()%3
		while(temp in tex_num ):
			temp = requiredRunes[i]*3  + randi()%3
		tex_num[i] = temp
			
		get_child(i).set_texture(rune_tex_array[tex_num[i]])
		
		
func _process(delta: float) -> void:

	if $AnimatedSprite2D.animation == "death":
		if alive:
			#$"../SFX".set_stream(break_sfx)
			#$"../SFX".play()
			orb_break_sfx.play()
			alive = false
		if$AnimatedSprite2D.frame == 6:
			$Rune_01.hide()
			$Rune_02.hide()
			$Rune_03.hide()
			$Base.hide()
		if$AnimatedSprite2D.frame == 11:
			queue_free()

func _testSeal() -> void:
	
	var orbsToTest = connectedOrbs.duplicate(true)
	var foundOrb
	var found
	var NotFound = false

	for i in range(len(requiredRunes)):
		foundOrb = false;
		found = false
		for orb in orbsToTest:
			if orb == null: continue
			if orb.runeID == requiredRunes[i]:
				print("match")
				foundOrb = orb
				found = true
				get_child(i).set_texture(rune_tex_array[tex_num[i]+9])
				rune_activated_sfx.play()
				break
		if found:
			orbsToTest.erase(foundOrb)
		else:
			print("rune not found")
			get_child(i).set_texture(rune_tex_array[tex_num[i]])
			NotFound = true
	if NotFound:
		print("Seal Not Broken")
	else:
		_breakSeal()
	pass


func _breakSeal() -> void:
	print("Seal Broken")
	$"../PowerUps".extra_turn(5)
	$"..".current_score += 1
	$AnimatedSprite2D.play("death")
	for orb in connectedOrbs:
		if orb == null: continue
		orb.connectedSeal = null
		orb._connectedToSeal(Array([], TYPE_OBJECT, "Node", Orb))
		#orb._pop()
