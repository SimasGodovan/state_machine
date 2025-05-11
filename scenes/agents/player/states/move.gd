extends LimboState

@export var animation_player: AnimationPlayer
@export var animation: StringName

func _enter() -> void:
	animation_player.play(animation)

func _update(delta: float) -> void:
	agent.apply_movement(delta)
	agent.update_sprite_direction()
	agent.check_jump_input()

	if agent.movement_input == Vector2.ZERO:
		print("transition from move to idle state")
		get_root().dispatch("to_idle")
