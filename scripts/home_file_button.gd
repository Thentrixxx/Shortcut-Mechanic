extends Button

var past_time
var current_time
var click: int
@export var double_click_time = 300

@onready var files_1: Window = $"../../../../Files1"
@onready var in_file: TextureRect = $"../../../../Files1/InFile"
@onready var in_file_2: TextureRect = $"../../../../Files1/InFile2"
@onready var in_bot: TextureRect = $"../../../../Files1/InBot"
@onready var file_button: Button = $"../../../../Files1/TaskBar/FileButton"
@onready var file_button_2: Button = $"../../../../Files1/TaskBar/FileButton2"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_time = Time.get_unix_time_from_system() * 1000


# When double clicked, sets the files open to the high level page.
func _on_button_up() -> void:
	click += 1
	if click == 1:
		past_time = current_time
	if click == 2:
		click = 0
		if current_time - past_time < double_click_time:
			if files_1.visible == false:
				files_1.visible = true
				in_bot.visible = true
				in_file.visible = false
				in_file_2.visible = false
				file_button.visible = false
				file_button_2.visible = false
			else:
				pass
