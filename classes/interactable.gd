class_name InteractableObject extends StaticBody2D

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func interact() -> void:
	push_warning("Method interact is not implemented for " + name)
