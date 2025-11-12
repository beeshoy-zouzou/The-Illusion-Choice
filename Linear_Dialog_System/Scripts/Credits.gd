class_name CreditsMenu
extends Control


signal exit_credits_menu


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		emit_signal("exit_credits_menu")


func _on_Exit_pressed():
	emit_signal("exit_credits_menu")
	set_process(false)
