extends Node2D
func extra_turn(amount):
	$"../Gun".turns += amount
	$"../UI/Turn".text = "Turn: %s" %$"../Gun".turns
	
