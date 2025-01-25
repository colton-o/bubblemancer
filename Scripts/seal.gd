extends StaticBody2D

class_name Seal
var requiredRunes: Array[int] = [0,0,0]

@export var rune_tex_array : Array

var tex_num : Array[int] = [10,10,10]

@export var connectedOrbs = Array([], TYPE_OBJECT, "Node", Orb)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(len(requiredRunes)):
		requiredRunes[i] = randi() % 3;
		var temp = requiredRunes[i]*3  + randi()%3
		while(temp in tex_num ):
			temp = requiredRunes[i]*3  + randi()%3
		tex_num[i] = temp
			
		get_child(i).set_texture(rune_tex_array[tex_num[i]])
		
	
		
	
		
		
	

func _testSeal() -> void:
	
	var orbsToTest = connectedOrbs.duplicate(true)
	var foundOrb
	var orbNotFound = false
	var foundOrbLocation

	for i in range(len(requiredRunes)):
		foundOrb = false;
		for orb in orbsToTest:
			if orb.runeID == requiredRunes[i]:
				print("match")
				foundOrbLocation = orbsToTest.bsearch(orb)
				foundOrb = true
			
				get_child(i).set_texture(rune_tex_array[tex_num[i]+9])
				break
		if foundOrb:
			orbsToTest.remove_at(foundOrbLocation)
		else:
			orbNotFound = true
	if orbNotFound:
		print("Seal Not Broken")
	else:
		_breakSeal()
	pass

func _breakSeal() -> void:
	print("Seal Broken")
	
