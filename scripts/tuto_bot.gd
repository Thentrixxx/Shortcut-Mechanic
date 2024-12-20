extends Window

signal button_pressed
@onready var button: Button = $Button
@onready var rich_text_label: RichTextLabel = $ColorRect/MarginContainer/RichTextLabel
@onready var robot_sprite: Sprite2D = $"Robot Sprite"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Emits a signal when the button is pressed
func _on_button_button_up() -> void:
	emit_signal("button_pressed")


func _on_close_requested() -> void:
	visible = false


func change_bot_sprite(sprite: String):
	robot_sprite.texture = ResourceLoader.load(sprite)
