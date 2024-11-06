extends Button

@onready var texture_rect: TextureRect = $"../../../../TextureRect"

@onready var is_pressed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_button_up() -> void:
	if is_pressed == true:
		texture_rect.visible = false
		is_pressed = false
		
	elif is_pressed == false:
		texture_rect.visible = true
		is_pressed = true
