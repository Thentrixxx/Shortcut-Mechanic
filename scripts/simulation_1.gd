extends Node2D

var dialogue_times_pressed = 0
var good_route_pressed = 0
var slow_route_pressed = 0

@onready var tuto_bot: Window = $Tuto_Bot
@onready var tuto_bot_text: RichTextLabel = $Tuto_Bot/ColorRect/MarginContainer/RichTextLabel

# Alt Up Arrow Related Stuff
@onready var in_file: TextureRect = $Files1/InFile
@onready var in_file_2: TextureRect = $Files1/InFile2
@onready var in_bot: TextureRect = $Files1/InBot
@onready var file_button: Button = $Files1/TaskBar/FileButton
@onready var file_button_2: Button = $Files1/TaskBar/FileButton2

# Ctrl N Related Stuff
@onready var files_1: Window = $Files1
@onready var files_2: Window = $Files2

#Ctrl Shift N Related Stuff
@onready var in_bot_file_2: Button = $Files1/InBot/MarginContainer2/HBoxContainer/InBotFile2

# Right Click Related Stuff
@onready var new_file_button: Button = $Files1/NewFileButton


var mouse_pos

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Tuto_Bot.connect("button_pressed", dialogue)

# Where Inputs are being looked for
func _process(delta: float) -> void:
	# When Alt+Up is pressed, go up in the directory.
	if (Input.is_action_just_pressed("alt+up_arrow")):
		in_file.visible = false
		in_file_2.visible = false
		file_button.visible = false
		file_button_2.visible = false
		in_bot.visible = true
	
	# When Ctrl+Shift+N is pressed, create a new file.
	if (Input.is_action_just_pressed("ctrl+shift+n")):
			if (files_1.visible == true):
				if (in_bot.visible == true):
					in_bot_file_2.visible = true
	
	# When Ctrl+Shift+N is pressed, duplicate the file.
	if (Input.is_action_just_pressed("ctrl+n")):
		if (files_1.visible == true):
			if (in_bot.visible == true):
				files_2.visible = true
	
	# When right click is pressed, make new file button visible
	if (Input.is_action_just_pressed("right_click")):
		new_file_button.visible = true
		new_file_button.position = get_viewport().get_mouse_position()
		new_file_button.position -= Vector2(files_1.position)


func _physics_process(delta: float) -> void:
	mouse_pos = get_viewport().get_mouse_position()


# When clicking the new file button, add a new file.
func _on_new_file_button_button_up() -> void:
	new_file_button.visible = false
	in_bot_file_2.visible = true





func dialogue() -> void:
	dialogue_times_pressed += 1
	if dialogue_times_pressed == 1:
		change_tuto_dialogue("Dialogue Changed")
	elif dialogue_times_pressed == 2:
		change_tuto_dialogue("Dialogue Changed Again")


func change_tuto_dialogue(dialogue: String):
	tuto_bot_text.text = dialogue
