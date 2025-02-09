extends CharacterBody2D
class_name Orb
@export var speed = 0
var active = true
var collision
@export var connectedOrbs = Array([], TYPE_OBJECT, "Node", Orb)
var connectedSeal
var runeID
@export var stuck = false

#Old Audio Implementation
#@export var bounce_sfx: Array[AudioStream]
#@export var impact_sfx: Array[AudioStream]
#@export var pop_sfx: Array[AudioStream]
#@export var seal_sfx: Array[AudioStream]

@onready var bounce_sfx = $Bounce
@onready var bubble_impact_sfx = $BubbleImpact
@onready var pop_sfx = $Pop
@onready var orb_impact_sfx = $OrbImpact

var ORB = load("res://Objects/Orb.tscn")

	
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
			#play_sfx(bounce_sfx[randi() %3])
			bounce_sfx.play()
		elif colName == "Bouncers":
			velocity = velocity.bounce(collision.get_normal())
			#play_sfx(bounce_sfx[randi() %3])
			bubble_impact_sfx.play()
		elif (collision.get_collider() is Orb):
			if collision.get_collider().stuck:
				connectedOrbs.append(collision.get_collider())
				collision.get_collider().connectedOrbs.append(self)
				velocity = Vector2.ZERO
				#play_sfx(impact_sfx[randi() %3])
				bubble_impact_sfx.play()
				_testFormulas()
				active = false
				stuck = true
			else:
				velocity = velocity.bounce(collision.get_normal())
				#play_sfx(bounce_sfx[randi() %3])
				bounce_sfx.play()
		elif (collision.get_collider() is Seal):
			collision.get_collider().connectedOrbs.append(self)
			collision.get_collider()._testSeal()
			velocity = Vector2.ZERO
			connectedSeal = collision.get_collider()
			active = false
			stuck = true
			#play_sfx(seal_sfx[randi() %3])
			orb_impact_sfx.play()
		
		else:
			velocity = Vector2.ZERO
			active = false
		
func _testFormulas() -> void:
	print("Test Life Formula")
	var orbs = _testFormula(self, Array([], TYPE_OBJECT, "Node", Orb), [0,0,0])
	if orbs.size() > 0:
		_completeFormula(orbs)
		$"../PowerUps".extra_turn(5)
		print("Give Life")
		return
	
	print("Test Take Life Formula")
	orbs = _testFormula(self, Array([], TYPE_OBJECT, "Node", Orb), [1,1,1])
	if orbs.size() > 0:
		_completeFormula(orbs)
		$"../PowerUps".extra_turn(5)
		print("Take Life")
		return
		
	print("Test Gold Formula")
	orbs = _testFormula(self, Array([], TYPE_OBJECT, "Node", Orb), [2,2,2])
	if orbs.size() > 0:
		_completeFormula(orbs)
		$"../PowerUps".extra_turn(5)
		print("Give Gold")
		return
	
	print("Test Bubble Formula")
	orbs = _testFormula(self, Array([], TYPE_OBJECT, "Node", Orb), [0,1,2])
	if orbs.size() > 0:
		_completeFormula(orbs)
		
		print("Bubbles")
		await get_tree().create_timer(.5, true).timeout
		$"../bubbles_for_Miles".position = self.position
		$"../bubbles_for_Miles".bubbleshit(ORB)
		return
		
	print("TESTMEGACHAIN")
	orbs = _testFormula(self, Array([], TYPE_OBJECT,"Node",Orb),[0,0,2,2])
	if orbs.size()>0 :
		_completeFormula(orbs)
		print("MORE SHOOTING")
		$"../PowerUps".extra_shot(1)
	
	
func _testFormula(currentOrb, collectedOrbs, formula : Array) -> Array:
	print("testing formula")
	if !currentOrb: return Array([], TYPE_OBJECT, "Node", Orb)
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
					if orb == null: continue
					var num = newCollectedOrbs.count(orb)
					if(num == 0):
						return _testFormula(orb, newCollectedOrbs, newFormula)
	return Array([], TYPE_OBJECT, "Node", Orb)
	
func _completeFormula(orbsUsed) -> void:
	
	for orb in orbsUsed:
		if orb == null: continue
		orb._pop()
	
func _connectedToSeal(testedOrbs : Array) -> bool:
	if connectedSeal != null:
		return true
	else:
		for orb in connectedOrbs:
			if orb == null: continue
			if testedOrbs.count(orb) == 0:
				testedOrbs.append(self)
				if orb._connectedToSeal(testedOrbs): return true
		_pop()
		return false
				
func _pop() -> void:
	get_node("CollisionShape2D").disabled = true 
	#play_sfx(pop_sfx[randi()%3])
	pop_sfx.play()
	if connectedSeal != null:
		if connectedSeal.connectedOrbs.count(self):
			connectedSeal.connectedOrbs.erase(self)
			connectedSeal._testSeal()
	for orb in connectedOrbs:
		if orb == null: continue
		orb.connectedOrbs.erase(self)
		orb._connectedToSeal(Array([], TYPE_OBJECT, "Node", Orb))
	$BubbleSprite.play("pop")
	await get_tree().create_timer(.5).timeout
	queue_free()
	
#func play_sfx(sound):
	#$"../SFX".set_stream(sound)
	#$"../SFX".play()
	
