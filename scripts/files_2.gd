extends Window

@onready var file_button_2: Button = $TaskBar/FileButton2
@onready var in_bot: TextureRect = $InBot
@onready var in_file: TextureRect = $InFile

# Variables for double clicking a button
var past_time
var current_time
var click: int
@export var double_click_time = 300


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_time = Time.get_unix_time_from_system() * 1000


func _on_close_requested() -> void:
	visible = false


func _on_bot_button_button_up() -> void:
	in_bot.visible = true
	in_file.visible = false
	file_button_2.visible = false


func _on_in_bot_file_2_button_up() -> void:
	click += 1
	if click == 1:
		past_time = current_time
	if click == 2:
		click = 0
		if current_time - past_time < double_click_time:
			in_bot.visible = false
			in_file.visible = true
			file_button_2.visible = true
