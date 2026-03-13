extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var piv: Node3D = $Piv
@onready var anim: AnimationPlayer = $Piv/buddybuddy/AnimationPlayer

var turn_vel = 7.5
var num_rotacao = deg_to_rad(0)
var andando = false
func _ready() -> void:
	GameManager.player["pos x"] = global_position.x
	GameManager.player["pos y"] = global_position.y
	GameManager.player["pos z"] = global_position.z
func _physics_process(delta: float) -> void:
	if GameManager.player["vida"] <= 0:
		queue_free()
		return
	animation(delta)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func animation(delta):
	if is_on_floor():
		
		if Input.is_action_pressed("ui_up"):
			andando = true
			anim.play("Walk")
			num_rotacao = deg_to_rad(0)
			if Input.is_action_pressed("ui_left"):
				num_rotacao = deg_to_rad(45)
			elif Input.is_action_pressed("ui_right"):
				num_rotacao = deg_to_rad(-45)
				
			piv.rotation.y = lerp_angle(piv.rotation.y, num_rotacao, turn_vel * delta)

		if Input.is_action_pressed("ui_down"):
			andando = true
			anim.play("Walk")
			num_rotacao = deg_to_rad(180)
			if Input.is_action_pressed("ui_left"):
				num_rotacao = deg_to_rad(135)
			elif Input.is_action_pressed("ui_right"):
				num_rotacao = deg_to_rad(-135)
				
			piv.rotation.y = lerp_angle(piv.rotation.y, num_rotacao, turn_vel * delta)
