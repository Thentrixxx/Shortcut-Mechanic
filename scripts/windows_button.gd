extends Button

@onready var texture_home_menu: TextureRect = $"../../../../TextureHomeMenu"
@onready var is_pressed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_button_up() -> void:
	if is_pressed == true:
		texture_home_menu.visible = false
		is_pressed = false
		
	elif is_pressed == false:
		texture_home_menu.visible = true
		is_pressed = true
