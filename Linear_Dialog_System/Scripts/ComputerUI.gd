extends CanvasLayer

onready var panel = $Panel
onready var message_label = $Panel/MessageLabel
onready var first_button = $Panel/VBoxContainer/FirstButton
onready var second_button = $Panel/VBoxContainer/SecondButton
onready var exit_button = $Panel/VBoxContainer/ExitButton 
onready var choice_sound_player = $ChoiceSoundPlayer

var first_callback_ref = null
var second_callback_ref = null

func _ready():
	hide_ui()
	first_button.connect("pressed", self, "_on_first_pressed")
	second_button.connect("pressed", self, "_on_second_pressed")
	exit_button.connect("pressed", self, "_on_exit_pressed") 

func show_ui(first_callback, second_callback):
	first_callback_ref = first_callback
	second_callback_ref = second_callback
	message_label.text = ""
	panel.visible = true

func hide_ui():
	panel.visible = false
	message_label.text = ""

func show_message(text):
	message_label.text = text

func _on_first_pressed():
	choice_sound_player.play()
	if first_callback_ref != null:
		first_callback_ref.call_func()

func _on_second_pressed():
	choice_sound_player.play()
	if second_callback_ref != null:
		second_callback_ref.call_func()

func _on_exit_pressed():
	choice_sound_player.play()
	if DoorPrompt.prompt_panel:
		DoorPrompt.hide_prompt()
	panel.visible = false
	message_label.text = ""
