extends Node2D

@onready var jogador: CharacterBody2D = $jogador
@onready var camera_jogador: Camera2D = $jogador/camera

func _ready() -> void:
	camera_jogador.zoom = Vector2(7, 7)


func _process(delta: float) -> void:
	pass
