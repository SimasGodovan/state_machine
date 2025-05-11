extends CharacterBody3D

const SPEED = 7.0
const JUMP_VELOCITY = 4

@export var state_machine: LimboHSM
@onready var idle_state: LimboState = $LimboHSM/Idle
@onready var move_state: LimboState = $LimboHSM/Move
@onready var jump_state: LimboState = $LimboHSM/Jump
@onready var fall_state: LimboState = $LimboHSM/Fall
@onready var attack_state: LimboState = $LimboHSM/Attack
@onready var air_attack_state: LimboState = $LimboHSM/AirAttack
@onready var crouch_state: LimboState = $LimboHSM/Crouch
@onready var sprite: Sprite3D = $Sprite3D

var movement_input: Vector2 = Vector2.ZERO

func _ready() -> void:
	_initialize_state_machine()

func _initialize_state_machine() -> void:
	state_machine.add_transition(state_machine.ANYSTATE, move_state, "to_move")
	state_machine.add_transition(state_machine.ANYSTATE, idle_state, "to_idle")
	state_machine.add_transition(state_machine.ANYSTATE, jump_state, "to_jump")
	state_machine.add_transition(state_machine.ANYSTATE, fall_state, "to_fall")

	state_machine.initial_state = idle_state
	state_machine.initialize(self)
	state_machine.set_active(true)

func update_sprite_direction():
	if movement_input.x != 0:
		sprite.flip_h = movement_input.x < 0

func apply_movement(delta: float) -> void:
	velocity.x = movement_input.x * SPEED
	velocity.y = movement_input.y * SPEED

func check_jump_input():
	if Input.is_action_just_pressed("jump"):
		print("transition to jump state")
		state_machine.dispatch("to_jump")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	movement_input = Input.get_vector("left", "right", "up", "down")

	move_and_slide()
