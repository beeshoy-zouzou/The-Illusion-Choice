extends Control


onready var exit = $MarginContainer/HBoxContainer/VBoxContainer/Exit
onready var background = $Background
onready var fade_overlay = $FadeOverlay
onready var tween = $Tween


# Called when the node enters the scene tree for the first time.
func _ready():
	fade_overlay.color = Color(0,0,0,1)
	tween.interpolate_property(
		fade_overlay, "color:a",
		1.0, 0.0, 1.5,
		Tween.TRANS_SINE, Tween.EASE_OUT
	)
	tween.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Exit_pressed():
	tween.interpolate_property(
		fade_overlay, "color:a",
		0.0, 1.0, 1.0,
		Tween.TRANS_SINE, Tween.EASE_IN
	)
	tween.start()
	yield(tween, "tween_completed")
	get_tree().change_scene("res://Scenes/MainMenu.tscn") 
