extends StaticBody2D

class_name Seal
var requiredRunes: Array[int] = [0,1,2]

@export var connectedOrbs = Array([], TYPE_OBJECT, "Node", Orb)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _testSeal() -> void:
	var orbsToTest = connectedOrbs
	var foundOrb
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
			
			print("Seal Not Broken")
			return
		
	_breakSeal()
	pass

func _breakSeal() -> void:
	print("Seal Broken")
	
