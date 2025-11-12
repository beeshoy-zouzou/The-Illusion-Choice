extends KinematicBody2D

signal talk_to_npc

signal talk_started  # Emitted when player presses "interact"
signal talk_finished # Emitted when conversation fully ends

var dialog_scene = preload("res://Scenes/DialogSystem/DialogSystem.tscn")

var dialog_instance = null

var player_in_range = false
var in_conversation = false

onready var sprite = $AnimatedSprite


func _ready():
	sprite.play("idle")
#	DoorPrompt.prompt_panel.rect_position.y -= 70
#	DoorPrompt.prompt_panel.rect_size = Vector2(180, 40)
#	DoorPrompt.label.align = DoorPrompt.label.ALIGN_CENTER

func _process(delta):
	if player_in_range and Input.is_action_just_pressed("interact") and not in_conversation:
		in_conversation = true
		start_conversation()

func start_conversation():
	Globals.player_can_move = false
	emit_signal("talk_started")
	DoorPrompt.hide_prompt()  # If you're using a global autoload prompt
	sprite.play("look_ui")
	#Dialog logic
	if dialog_instance:
		dialog_instance.queue_free()
		dialog_instance = null
	dialog_instance = dialog_scene.instance()
	var dialog_script_node = dialog_instance.get_node("DialogSystem")
	dialog_script_node.caller_npc = self  # ✅ correct

	get_tree().get_root().add_child(dialog_instance)
	
#	dialog_instance._ink_player.ink_file = load(dialog_path)
#	dialog_instance._ink_player.create_story()

	
	var x = dialog_instance.get_node("DialogSystem/DialogBox")
	x.rect_position.y += 180
	x.rect_position.x += 15

#	DialogSystem.visible = true
#	DialogSystem.dialog_box.visible = true
#	DialogSystem.dialog_box.rect_position = Vector2(1100, 400)
#
#	DialogSystem.start_dialog("res://Stories/LinearDialog/PartOne/PartOne.ink.json")
#	DialogSystem.connect("tree_exited", self, "end_conversation", [], CONNECT_ONESHOT)
#	Globals.talked_to_beeshoy = true 
#	print("Conversation finished. Doors can unlock.")
#	emit_signal("talk_to_npc")

func end_conversation():


	Globals.player_can_move = true
#	sprite.play("look_end")
#	yield(get_tree().create_timer(3), "timeout")
	
#	yield(sprite, "animation_finished")
#	Globals.player_can_move = true
	sprite.play("idle")
	in_conversation = false
	Globals.talked_to_beeshoy = true 
	print("Conversation finished. Doors can unlock.")
	emit_signal("talk_to_npc")
	
	
func remove_dialog_instance():
	Globals.player_can_move = true
	if dialog_instance:
		dialog_instance.queue_free()
		dialog_instance = null
		
func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true
		DoorPrompt.show_prompt("Press Q to talk")

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		DoorPrompt.hide_prompt()
		if in_conversation:
			remove_dialog_instance()
			end_conversation()
			
#			sprite.play("look_end")
#			yield(sprite, "animation_finished")
#			sprite.play("idle")
#			in_conversation = false
#func _on_dialog_closed():
#	end_conversation()
#	Globals.talked_to_beeshoy = true 
#	print("Conversation finished. Doors can unlock.")
#	emit_signal("talk_to_npc")

#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
