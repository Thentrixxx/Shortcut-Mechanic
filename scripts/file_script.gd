extends Button

@onready var sprite_2d: Sprite2D = $Sprite2D

var is_pressed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_up() -> void:
	if is_pressed == false:
		sprite_2d.texture=ResourceLoader.load("res://assets/File_Selected.webp")
		is_pressed = true
	#elif is_pressed == true:
		#sprite_2d.texture=ResourceLoader.load("res://assets/File_Unselected.webp")
		#is_pressed = false
