extends LimboState

@export var animation_player: AnimationPlayer
@export var animation: StringName

func _enter() -> void:
	animation_player.play(animation)

func _update(delta) -> void:
	agent.apply_movement(delta)
	
	if agent.is_on_floor() and agent.movement_input == Vector2.ZERO:
		print("transition from fall to idle state")
		get_root().dispatch("to_idle")
	elif agent.is_on_floor() and agent.movement_input != Vector2.ZERO:
		print("transition from fall to move state")
		get_root().dispatch("to_move")
