extends CharacterBody3D

@export var speed: float = 5.0

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D

var target_position: Vector3 = Vector3.ZERO
var is_ready_to_move: bool = false

func _ready() -> void:
	# Wait for the navigation map to sync its first physics frame
	call_deferred("setup_navigation")

func setup_navigation() -> void:
	await get_tree().physics_frame
	if target_position != Vector3.ZERO:
		nav_agent.target_position = target_position
	is_ready_to_move = true

func set_target(new_target: Vector3) -> void:
	target_position = new_target
	if is_instance_valid(nav_agent):
		nav_agent.target_position = new_target

func _physics_process(_delta: float) -> void:
	# Don't move until the navigation map has synchronized
	if not is_ready_to_move:
		return

	if nav_agent.is_navigation_finished():
		_on_reach_goal()
		return

	var next_path_pos: Vector3 = nav_agent.get_next_path_position()
	var direction: Vector3 = (next_path_pos - global_position)
	direction.y = 0.0
	direction = direction.normalized()

	velocity = direction * speed
	
	if direction.length_squared() > 0.001:
		look_at(global_position + direction, Vector3.UP)

	move_and_slide()

func _on_reach_goal() -> void:
	print("Reached goal!")
	queue_free()
