extends StaticBody2D

class_name Seal
var requiredRunes: Array[int] = [0,1,2]

@export var connectedOrbs = Array([], TYPE_OBJECT, "Node", Orb)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.




func _testSeal() -> void:
	var orbsToTest = connectedOrbs.duplicate(true)
	var foundOrb
	var orbNotFound = false
	var foundOrbLocation
	var index = 0
	for runeID in requiredRunes:
		foundOrb = false;
		for orb in orbsToTest:
			print("id= ",  orb.runeID)
			print ("checking", runeID)
			if orb.runeID == runeID:
				print("index= ", index)
				foundOrbLocation = orbsToTest.bsearch(orb)
				foundOrb = true
				get_child(index).activate()
				break
		if foundOrb:
			orbsToTest.remove_at(foundOrbLocation)
		else:
			orbNotFound = true
		index += 1
	if orbNotFound:
		print("Seal Not Broken")
	else:
		_breakSeal()
	pass

func _breakSeal() -> void:
	print("Seal Broken")
	
