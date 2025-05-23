extends LimboState

@export var animation_player: AnimationPlayer
@export var animation: StringName

func _enter() -> void:
	animation_player.play(animation)

func _update(delta: float) -> void:
	agent.check_jump_input()
	agent.check_crouch_input()
	agent.check_attack_input()
	if agent.movement_input != Vector2.ZERO:
		print("transition from idle to move state")
		get_root().dispatch("to_move")
