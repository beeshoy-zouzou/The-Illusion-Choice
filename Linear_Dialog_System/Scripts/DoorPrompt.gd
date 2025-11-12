extends CanvasLayer

onready var label = $PromptPanel/Label
onready var prompt_panel = $PromptPanel
onready var message_panel = $MessagePanel
onready var door_label = $MessagePanel/DoorLabel



func _ready():
	prompt_panel.visible = false
	message_panel.visible = false

func show_prompt(text: String):
	label.text = text
	prompt_panel.visible = true
	message_panel.visible = false
	
	
	

func hide_prompt():
	prompt_panel.visible = false
	label.text = ""

func show_message(text: String):
	door_label.text = text
	message_panel.visible = true
	prompt_panel.visible = false

func hide_message():
	message_panel.visible = false
	door_label.text =  ""
