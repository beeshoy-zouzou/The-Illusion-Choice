extends Control


onready var start = $Start
onready var credits = $Credits
onready var exit = $Exit
onready var credits_menu = $CreditsMenu
onready var margin_container = $MarginContainer

export var start_level = preload("res://Scenes/Main.tscn") 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.





func _on_Exit_pressed():
	get_tree().quit()


func _on_Start_pressed():
	get_tree().change_scene_to(start_level)


func _on_Credits_pressed():
	margin_container.visible = false
	start.visible = false
	credits.visible = false
	exit.visible = false
	credits_menu.set_process(true)
	credits_menu.visible = true





func _on_CreditsMenu_exit_credits_menu():
	print("Exiting credits menu")  # Debug check
	margin_container.visible = true
	start.visible = true
	credits.visible = true
	exit.visible = true
	credits_menu.visible = false
