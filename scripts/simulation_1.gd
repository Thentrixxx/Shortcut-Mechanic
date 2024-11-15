extends Node2D

var dialogue_times_pressed = 0
var finished_dialogue_times_pressed = 0
var first_route_pressed = 0
var second_route_pressed = 0
var times_n_pressed = 0
var times_shift_n_pressed = 0

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
@onready var w2_in_bot_file_2: Button = $Files2/InBot/MarginContainer2/HBoxContainer/InBotFile2

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


# Desktop Buttons
@onready var home_button_tuto_bot: Button = $Control/MarginHomePage/HomePage/ButtonTutoBot
@onready var home_button_file: Button = $Control/MarginHomePage/HomePage/HomeFileButton


# Debug Window
@onready var debug_text: RichTextLabel = $"Debug Window/RichTextLabel"



var is_simulation_finished: bool = false
var is_grabbed_on: bool = false
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
				w2_in_bot_file_2.visible = true
				if times_shift_n_pressed == 0:
					LevelManager.add_score("Shortcut_Ctrl+Shift+N", 100)
					update_debug_text("Added 100 Points to Shortcut_Ctrl+Shift+N")
					times_shift_n_pressed += 1
	
	# When Ctrl+Shift+N is pressed, duplicate the file.
	if (Input.is_action_just_pressed("ctrl+n")):
		is_file_created += 1
		if is_file_created >= 2:
			if (files_1.visible == true):
				if (in_bot.visible == true):
					files_2.visible = true
					if times_n_pressed == 0:
						LevelManager.add_score("Shortcut_Ctrl+N", 100)
						update_debug_text("Added 100 Points to Shortcut_Ctrl+N")
						times_n_pressed += 1
	
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
			# Tells the Dialogue that the simulation is finished
			is_simulation_finished = true
			LevelManager.subtract_score("Shortcut_Ctrl+N", 100)
			LevelManager.subtract_score("Shortcut_Alt+Up", 100)
			update_debug_text("Subtracted 100 Points from Shortcut_Ctrl+N")
			update_debug_text("Subtracted 50 Points from Shortcut_Alt+Up")
			change_tuto_dialogue("You did it! What a job well done.")
	
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
			# w1 files invisible, w2 files visible.
			w1_file_button_4.visible = false
			w1_file_button_5.visible = false
			w1_file_button_6.visible = false
			w2_file_button.visible = true
			w2_file_button_2.visible = true
			w2_file_button_3.visible = true
			# Tells the Dialogue that the simulation is finished
			is_simulation_finished = true
			LevelManager.subtract_score("Shortcut_Alt+Up", 100)
			update_debug_text("Subtracted 50 Points from Shortcut_Alt+Up")
			change_tuto_dialogue("You did it! What a job well done.")


func _physics_process(delta: float) -> void:
	mouse_pos = get_viewport().get_mouse_position()
	files_grabbed_window.position = mouse_pos


# When clicking the new file button, add a new file.
func _on_new_file_button_button_up() -> void:
	new_file_button.visible = false
	in_bot_file_2.visible = true
	w2_in_bot_file_2.visible = true
	LevelManager.subtract_score("Shortcut_Ctrl+Shift+N", 100)
	update_debug_text("Subtracted 100 Points from Shortcut_Ctrl+Shift+N")

# Dialogue for Tuto Bot.
func dialogue() -> void:
	# When the game is booted up
	if is_simulation_finished == false:
		dialogue_times_pressed += 1
		if dialogue_times_pressed == 1:
			change_tuto_dialogue("Here, you can learn about shortcuts in a fun and effective way!")
			
		elif dialogue_times_pressed == 2:
			change_tuto_dialogue("You'll be working on broken robots by repairing their operating systems.")
			
		elif dialogue_times_pressed == 3:
			change_tuto_dialogue("Let's get you started with a bit of a knowledge check!")
			
		elif dialogue_times_pressed == 4:
			change_tuto_dialogue("ENTERING SIMULATION...")
			
		elif dialogue_times_pressed == 5:
			change_tuto_dialogue("Say hello to Bort!")
			#Adding the shortcuts
			LevelManager.add_shortcut("Shortcut_Ctrl+N", 100, 1)
			LevelManager.add_shortcut("Shortcut_Ctrl+Shift+N", 100, 2)
			LevelManager.add_shortcut("Shortcut_Alt+Up", 50, 4)
			update_debug_text("Shortcut Added: Ctrl+N, Score: 100, Priority: 1")
			update_debug_text("Shortcut Added: Ctrl+Shift+N, Score: 100, Priority: 2")
			update_debug_text("Shortcut Added: Alt+Up, Score: 50, Priority: 4")
			
		elif dialogue_times_pressed == 6:
			change_tuto_dialogue("He's not looking so hot. In fact, I think he's a bit overloaded...")
			
		elif dialogue_times_pressed == 7:
			change_tuto_dialogue("Maybe we just need to separate his contents a bit!")
			
		elif dialogue_times_pressed == 8:
			change_tuto_dialogue("I've given you access to his files system, it should be located on your desktop.")
			home_button_file.visible = true
			
		elif dialogue_times_pressed >= 9:
			change_tuto_dialogue("Create a new folder for him in the scene tree, then split some of the files into that folder.")
	
	# After the simulation is finished
	elif is_simulation_finished == true:
		finished_dialogue_times_pressed += 1
		if finished_dialogue_times_pressed == 1:
			change_tuto_dialogue("Now that you've helped Bort out, let's help you to learn some new shortcuts!")
			files_1.visible = false
			files_2.visible = false
			home_button_file.visible = false
			LevelManager.print_shortcuts()

func change_tuto_dialogue(dialogue: String):
	tuto_bot_text.text = dialogue

func update_debug_text(text: String):
	debug_text.add_text(text + "\n")
