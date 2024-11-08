extends Node2D

var times_pressed = 0

@onready var tuto_bot: Window = $Tuto_Bot
@onready var tuto_bot_text: RichTextLabel = $Tuto_Bot/ColorRect/MarginContainer/RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Tuto_Bot.connect("button_pressed", dialogue)


func dialogue() -> void:
	times_pressed += 1
	if times_pressed == 1:
		change_tuto_dialogue("Dialogue Changed")
	elif times_pressed == 2:
		change_tuto_dialogue("Dialogue Changed Again")


func change_tuto_dialogue(dialogue: String):
	tuto_bot_text.text = dialogue
