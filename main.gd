extends Node2D

@onready var popup = $Window

# Called when the node enters the scene tree for the first time.
func _ready():
	popup.show()
	button_cosmetics()

func _on_window_close_requested():
	popup.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

var button_text: String = "Press Me"

func button_cosmetics():
	var button = $Button
	button.text = "Click me"
	button.pressed.connect(self._button_pressed)
	
func _button_pressed():
	print("Hello world!")
