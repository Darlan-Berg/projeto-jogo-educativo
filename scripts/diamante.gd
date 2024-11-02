extends Area2D

var valor_diamante := 1
@onready var som_coletado := $som_coletado as AudioStreamPlayer


func _on_body_entered(body: Node2D) -> void:
	som_coletado.play()
	$anim.play("coletado") # Tocar a animação "coletado" quando o player entrar na área do diamante
	await $colisor.call_deferred(("queue_free()")) # Evita que o player colete o mesmo diamante duas vezes
	Global.diamantes += valor_diamante
	Global.score += 100
	
func _on_anim_animation_finished() -> void:
	queue_free() # Exluir o diamante assim que a animação "coletado" for terminada
