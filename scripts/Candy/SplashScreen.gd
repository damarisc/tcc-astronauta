extends Node

func _on_Timer_timeout():
	Transition.fade_to("res://Scenes/Candy/MainScreen.tscn")
