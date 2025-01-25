extends StaticBody2D
class_name Seal
var requiredRuins: Array[int] = [0,0,0]
@export var connectedOrbs = Array([], TYPE_OBJECT, "Node", Orb)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _testSeal() -> void:
	print("Testing Seal")
	var orbsToTest = connectedOrbs
	var foundOrb
	var foundOrbLocation
	for ruinID in requiredRuins:
		for orb in orbsToTest:
			if orb.ruinID == ruinID:
				foundOrbLocation = orbsToTest.bsearch(orb)
				foundOrb = true
				break
		if foundOrb:
			orbsToTest.remove_at(foundOrbLocation)
		else:
			pass
	_breakSeal()
	pass

func _breakSeal() -> void:
	print("Seal Broken")
	
	pass
