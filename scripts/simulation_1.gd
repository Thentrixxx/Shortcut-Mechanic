extends Node2D

var dialogue_times_pressed = 0
var first_route_pressed = 0
var second_route_pressed = 0

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
var is_file_created = 0

# Right Click Related Stuff
@onready var new_file_button: Button = $Files1/NewFileButton

# Sprite for the files being grabbed
@onready var files_grabbed_window: Window = $"Files_Grabbed Window"

# Moved files
@onready var w1_file_button_4: Button = $Files1/InFile/MarginContainer/HBoxContainer/File_Button4
@onready var w1_file_button_5: Button = $Files1/InFile/MarginContainer/HBoxContainer/File_Button5
@onready var w1_file_button_6: Button = $Files1/InFile/MarginContainer/HBoxContainer/File_Button6
@onready var top_file_button: Button = $Files1/InBot/MarginContainer2/HBoxContainer/File_Button
@onready var top_file_button_2: Button = $Files1/InBot/MarginContainer2/HBoxContainer/File_Button2
@onready var top_file_button_3: Button = $Files1/InBot/MarginContainer2/HBoxContainer/File_Button3
@onready var f2_file_button: Button = $Files1/InFile2/MarginContainer/HBoxContainer/File_Button
@onready var f2_file_button_2: Button = $Files1/InFile2/MarginContainer/HBoxContainer/File_Button2
@onready var f2_file_button_3: Button = $Files1/InFile2/MarginContainer/HBoxContainer/File_Button3
@onready var w2_file_button: Button = $Files2/InFile/MarginContainer/HBoxContainer/File_Button
@onready var w2_file_button_2: Button = $Files2/InFile/MarginContainer/HBoxContainer/File_Button2
@onready var w2_file_button_3: Button = $Files2/InFile/MarginContainer/HBoxContainer/File_Button3


var is_grabbed_on = false
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
		is_file_created += 1
		if is_file_created >= 2:
			if (files_1.visible == true):
				if (in_bot.visible == true):
					files_2.visible = true
	
	# When right click is pressed, make new file button visible
	if (Input.is_action_just_pressed("right_click")):
		new_file_button.visible = true
		new_file_button.position = get_viewport().get_mouse_position()
		new_file_button.position -= Vector2(files_1.position)
	
	# Stuff for helping with route 1
	if (Input.is_action_just_pressed("ctrl+left_click")):
		first_route_pressed += 1
		# Dragging the files up into the directory
		if first_route_pressed == 1:
			files_grabbed_window.visible = true
			is_grabbed_on = true
		elif first_route_pressed == 2:
			files_grabbed_window.visible = false
			is_grabbed_on = false
			w1_file_button_4.visible = false
			w1_file_button_5.visible = false
			w1_file_button_6.visible = false
			top_file_button.visible = true
			top_file_button_2.visible = true
			top_file_button_3.visible = true
		# Dragging the files into the second file
		elif first_route_pressed == 3:
			files_grabbed_window.visible = true
			is_grabbed_on = true
		elif first_route_pressed == 4:
			files_grabbed_window.visible = false
			is_grabbed_on = false
			top_file_button.visible = false
			top_file_button_2.visible = false
			top_file_button_3.visible = false
			f2_file_button.visible = true
			f2_file_button_2.visible = true
			f2_file_button_3.visible = true
	
	# Stuff for helping with route 2
	if (Input.is_action_just_pressed("alt+left_click")):
		# Dragging the files to the other window
		second_route_pressed += 1
		if second_route_pressed == 1:
			files_grabbed_window.visible = true
			is_grabbed_on = true
		if second_route_pressed == 2:
			files_grabbed_window.visible = false
			is_grabbed_on = false
			w1_file_button_4.visible = false
			w1_file_button_5.visible = false
			w1_file_button_6.visible = false
			w2_file_button.visible = true
			w2_file_button_2.visible = true
			w2_file_button_3.visible = true


func _physics_process(delta: float) -> void:
	mouse_pos = get_viewport().get_mouse_position()
	files_grabbed_window.position = mouse_pos


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
