extends Area2D

@onready var som_coleta: AudioStreamPlayer = $som_coleta

var diamonds_score := 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	
	som_coleta.play()
	$anim.play("coletado") # Tocar a animação "coletado" quando o player entrar na área do diamante
	
	Global.diamantes_coletados.append(str(name))
	Global.diamantes += 1
	Global.score += 100
	

func _on_anim_animation_finished() -> void:
	queue_free()
