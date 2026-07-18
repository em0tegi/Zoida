extends CharacterBody2D

const SPEED = 300.0

@export var animation_tree: AnimationTree
@onready var animation_player := $AnimationPlayer

var health := 100

var is_dead := false
var is_ready_to_die := false
var got_hit := false

func _ready() -> void:
	add_to_group("enemy")
	animation_tree.active = true

func _physics_process(_delta: float) -> void:
	var idle := !velocity
	
	animation_tree.set("parameters/Run/blend_position", velocity.normalized())
	animation_tree.set("parameters/Idle/blend_position", velocity.normalized())
	animation_tree.set("parameters/Die/blend_position", velocity.normalized())
	
	move_and_slide()

func get_damage(damage: int) -> void:
	if health > 0:
		health -= damage
		got_hit = true
	if health <= 0:
		is_ready_to_die = true

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name.begins_with("hit"):
		if !is_ready_to_die:
			got_hit = false
		else:
			got_hit = false
			is_dead = true
	if anim_name.begins_with("death"):
		queue_free()
