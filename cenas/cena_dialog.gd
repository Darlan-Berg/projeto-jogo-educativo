extends CanvasLayer

var dialogues = ["Texto 1 do diálogo.", "Texto 2 do diálogo.", "Texto 3 do diálogo."]
var dialogue_index = 0
var is_dialogue_active = false

func show_next_dialogue():
	if dialogue_index < dialogues.size():
		$Label.text = dialogues[dialogue_index]
		dialogue_index += 1
	else:
		hide_dialogue()

func start_dialogue():
	is_dialogue_active = true
	dialogue_index = 0
	show_next_dialogue()
	self.visible = true  # Torna a interface de diálogo visível

func hide_dialogue():
	is_dialogue_active = false
	self.visible = false  # Esconde a interface de diálogo

func _input(event):
	if is_dialogue_active and event.is_action_pressed("ui_accept"):
		show_next_dialogue()
