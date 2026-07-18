extends CharacterBody2D

const SPEED = 300.0

@export var animation_tree: AnimationTree

var last_facing_direction := Vector2.ZERO

var attacking := false

var current_interactable = null

var damage := 50

func _ready() -> void:
	add_to_group("player")
	animation_tree.active = true

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and current_interactable:
		_interact()
	if Input.is_action_just_pressed("attack"):
		velocity = Vector2.ZERO
		_attack()
	if !attacking:
		var direction := Input.get_vector("left", "right", "up", "down")
		var idle := !velocity
			
		if !idle:
			last_facing_direction = velocity.normalized()
		
		velocity = direction * SPEED
		
		animation_tree.set("parameters/PlayerStates/Run/blend_position", last_facing_direction)
		animation_tree.set("parameters/PlayerStates/Idle/blend_position", last_facing_direction)
		animation_tree.set("parameters/PlayerStates/Attack/blend_position", last_facing_direction)
		
		move_and_slide()

func _attack() -> void:
	attacking = true

func _interact() -> void:
	current_interactable.interact()

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name.begins_with("attack"):
		attacking = false

func toggle_current_object(reference) -> void:
	if current_interactable == null:
		current_interactable = reference
	else:
		current_interactable = null

func _on_sword_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy") and body.has_method("get_damage"):
		body.get_damage(damage)
