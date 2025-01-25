extends StaticBody2D

class_name Seal
var requiredRunes: Array[int] = [0,1,0]

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

	for runeID in requiredRunes:
		foundOrb = false;
		for orb in orbsToTest:
			if orb.runeID == runeID:
				foundOrbLocation = orbsToTest.bsearch(orb)
				foundOrb = true
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
	
