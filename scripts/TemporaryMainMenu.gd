extends Node

func _on_GoToFlappyBird_pressed():
	Transition.fade_to("res://scenes/Flappy/FlappyGame.tscn")

func _on_GoToFuitNinja_pressed():
	Transition.fade_to("res://scenes/Ninja/game.tscn")

func _on_GoToSpinner_pressed(): #precisa arrumar
	Transition.fade_to("res://scenes/Spinner/game.tscn")

func _on_GoToTimberMan_pressed():
	Transition.fade_to("res://scenes/Timber/MainScene.tscn")

func _on_GoToSuperMario_pressed(): #precisa arrumar
	Transition.fade_to("res://scenes/Mario/game.tscn")

func _on_GoToCandyCrush_pressed():
	Transition.fade_to("res://scenes/Candy/SplashScreen.tscn")
