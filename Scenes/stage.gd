extends Node3D

@onready var goal: Marker3D = $EnemyGoal
@onready var enemy: CharacterBody3D = $Enemy
@onready var nav_region: NavigationRegion3D = $NavigationRegion3D

func _ready() -> void:
	if enemy and goal:
		# Tell the enemy where to go
		enemy.set_target(goal.global_position)
