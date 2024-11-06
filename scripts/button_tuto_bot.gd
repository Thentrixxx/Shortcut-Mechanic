extends Button

@onready var tuto_bot: Window = $"../../../../Tuto_Bot"


var past_time
var current_time
@export var double_click_time = 250

var click: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_time = Time.get_unix_time_from_system() * 1000

#func _input(e):
	#if e is InputEventMouseButton and e.button_index == MOUSE_BUTTON_LEFT and e.double_click:
		#tuto_bot.visible = true

func _on_button_up() -> void:
	click += 1
	if click == 1:
		past_time = current_time
	if click == 2:
		click = 0
		if current_time - past_time < double_click_time:
			tuto_bot.visible = true
	
