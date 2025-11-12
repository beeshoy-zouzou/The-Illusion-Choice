extends Node2D


onready var logo_sound = $LogoSound

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Fade in")
	
	yield(get_tree().create_timer(3),"timeout")
	logo_sound.play()
	yield(get_tree().create_timer(3), "timeout")
	$AnimationPlayer.play("Fade out")
	yield(get_tree().create_timer(3),"timeout")
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

