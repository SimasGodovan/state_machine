extends LimboState

@export var animation_player: AnimationPlayer
@export var animation: StringName

func _enter() -> void:
	animation_player.play(animation)

func _update(delta: float) -> void:
	if Input.is_action_just_released("crouch"):
		print("transition from crouch to idle state")
		agent.state_machine.dispatch("to_idle")
