extends Button

@onready var tuto_bot: Window = $"../../../../Tuto_Bot"


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


func _on_button_up() -> void:
	click += 1
	if click == 1:
		past_time = current_time
	if click == 2:
		click = 0
		if current_time - past_time < double_click_time:
			tuto_bot.visible = true
