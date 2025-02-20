extends Node2D

@onready var player: CharacterBody2D = $Player

func _ready() -> void:
	pass
	
func reload_game():
	get_tree().reload_current_scene()
