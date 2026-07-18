extends InteractableObject

@onready var sprite := $AnimatedSprite2D

var is_opened := false
var loot := ["Apple", "Wood", "Rock"]

func _ready() -> void:
	add_to_group("interactable_object")

func _process(_delta: float) -> void:
	pass

func _on_interact_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and body.has_method("toggle_current_object"):
		body.toggle_current_object(self)

func _on_interact_zone_body_exited(body: Node2D) -> void:
	if body.is_in_group("player") and body.has_method("toggle_current_object"):
		body.toggle_current_object(self)

func interact() -> void:
	if not is_opened:
		var item: String = loot.pick_random()
		is_opened = true
		sprite.play("open")
		print("You just looted " + item)
