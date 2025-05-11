extends LimboState

@export var animation_player: AnimationPlayer
@export var animation: StringName

func _enter() -> void:
	animation_player.play(animation)
	agent.velocity.y = agent.JUMP_VELOCITY

func _update(delta: float) -> void:
	agent.apply_movement(delta)

	if agent.velocity.y < 0 and !agent.is_on_floor():
		print("transition from jump to fall state")
		get_root().dispatch("to_fall")
