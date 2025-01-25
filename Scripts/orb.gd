extends CharacterBody2D
class_name Orb
@export var speed = 0
var active = true
var collision
@export var connectedOrbs = Array([], TYPE_OBJECT, "Node", Orb)
var runeID




	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2(0, -1*speed).rotated(rotation)
	


	
	
			
func _physics_process(delta: float) -> void:
	if active:
		collision = move_and_collide(velocity*delta)
	else: 
		collision = null
	if(collision):
		var colName = collision.get_collider().name
		
			
		if colName == "walls":
			velocity = velocity.bounce(collision.get_normal())
		
		elif (collision.get_collider() is Orb):
			connectedOrbs.append(collision.get_collider())
			collision.get_collider().connectedOrbs.append(self)
			velocity = Vector2.ZERO
			_testFormulas()
			active = false
		elif (collision.get_collider() is Seal):
			collision.get_collider().connectedOrbs.append(self)
			collision.get_collider()._testSeal()
			velocity = Vector2.ZERO
			
			active = false
		
		else:
			velocity = Vector2.ZERO
			
			active = false
		
func _testFormulas() -> void:
	print("Test Life Formula")
	var orbs = _testFormula(self, Array([], TYPE_OBJECT, "Node", Orb), [0,0,0])
	if orbs.size() > 0:
		_completeFormula(orbs)
		print("Give Life")
		return
	
	print("Test Take Life Formula")
	orbs = _testFormula(self, Array([], TYPE_OBJECT, "Node", Orb), [1,1,1])
	if orbs.size() > 0:
		_completeFormula(orbs)
		print("Take Life")
		return
		
	print("Test Gold Formula")
	orbs = _testFormula(self, Array([], TYPE_OBJECT, "Node", Orb), [2,2,2])
	if orbs.size() > 0:
		_completeFormula(orbs)
		print("Give Gold")
		return
	
	
func _testFormula(currentOrb, collectedOrbs, formula : Array) -> Array:
	print("testing formula")
	for runeID in formula:
		if currentOrb.runeID == runeID:
			collectedOrbs.append(currentOrb)
			var newCollectedOrbs = collectedOrbs.duplicate(true)
			var newFormula = formula.duplicate(true)
			newFormula.erase(currentOrb.runeID)
			if newFormula.is_empty():
				_completeFormula(collectedOrbs)
				return collectedOrbs
			else:
				for orb in currentOrb.connectedOrbs:
					var num = newCollectedOrbs.count(orb)
					if(num == 0):
						return _testFormula(orb, newCollectedOrbs, newFormula)
	return Array([], TYPE_OBJECT, "Node", Orb)
	
func _completeFormula(orbsUsed) -> void:
	for orb in orbsUsed:
		orb._pop()
	
func _pop() -> void:
	queue_free()
