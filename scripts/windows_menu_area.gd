extends Area2D

@onready var texture_rect: TextureRect = $"../Control/TextureRect"
@onready var collision: CollisionShape2D = $CollisionShape2D



func _on_mouse_exited() -> void:
	texture_rect.visibile = false

func _on_mouse_entered() -> void:
	pass # Replace with function body.
