extends Node

onready var map_node = $Map
onready var map = $Map/Map
onready var scene_one_room = $Map/SceneOneRoom
onready var player = $Player/Player
onready var npc = $Beeshoy/BeeshoyNPC
onready var npc1 = $Beeshoy/SecondBeeshoyNPC
onready var npc2 = $Beeshoy/ThirdNpc
onready var npc3 = $Beeshoy/FourthBeeshoyNpc
onready var butler = $Butler/Butler


func _ready():
	npc.visible = false
	npc1.visible = false
	npc2.visible = false
	npc3.visible = false
	butler.visible = false
	
	print("=== SIGNAL CONNECTION CHECK ===")
	for child in map_node.get_children():
		child.visible = (child.name == "Map")
	print("Connecting doors...")
	for door in get_tree().get_nodes_in_group("doors"):
		if door.is_connected("request_transition", self, "_on_door_transition_requested"):
			print("Already connected:", door.name)
		else:
			var result = door.connect("request_transition", self, "_on_door_transition_requested")
			print("Connection result for", door.name, ":", result)

func _on_door_transition_requested(target_map_name, target_door_name):
#	target_map_name = "SceneOneRoom"
#	target_door_name = "DoorTwo"
	print("### TRANSITION HANDLER TRIGGERED ###")
	print("Target Map: ", target_map_name)
	print("Target Door: ", target_door_name)
	print("SIGNAL RECEIVED! Target:", target_map_name, "| Door:", target_door_name)
	for child in map_node.get_children():
		print("Hiding map: ", child.name)
		child.visible = false
	
	var target_map = map_node.get_node_or_null(target_map_name)
	if target_map == null:
		push_error("FATAL: Target map not found - " + target_map_name)
		return
	print("Found target map: ", target_map.name)
	
	
	var door_node = target_map.find_node(target_door_name, true, false)
	if door_node == null:
		push_error("FATAL: Target door not found in map - " + target_door_name)
		return
	print("Teleporting player to door:", door_node.name)
	
	var exit_marker = door_node.get_node_or_null("ExitPos")
	if exit_marker:
		print("Teleporting to ExitPos under door:", exit_marker.global_position)
		player.global_position = exit_marker.global_position
	else:
		print("ExitPos not found. Using door's position:", door_node.global_position)
		player.global_position = door_node.global_position
		

#	player.global_position = door_node.global_position
	
#	var exit_pos_name = target_door_name + "_ExitPos"	
#	var exit_pos = target_map.find_node(exit_pos_name, true, false)
##	var exit_pos = target_map.find_node(target_door_name + "_ExitPos", true, false)
#	if !exit_pos:
#		push_error("Exit position not found: " + exit_pos_name )
#		return
#	print("Found exit position at: ", exit_pos.global_position)
		
#	player.global_position = exit_pos.global_position
	target_map.visible = true
	print("Transitioned Completed")
	npc.visible = (target_map_name == "SceneOneRoom")
	npc1.visible = (target_map_name == "SceneTwoRoomAndInterrogationSetup")
	npc2.visible = (target_map_name == "MysteryRoom")
	npc3.visible = (target_map_name == "RevealRoom")
	butler.visible = (target_map_name == "FinalMap")
	



	

























	
