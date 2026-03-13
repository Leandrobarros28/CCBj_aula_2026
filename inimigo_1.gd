extends Node3D
var cooldown = true
var vida = 1
var speed = 2
@onready var anim: AnimationPlayer = $Path3D/PathFollow3D/Pivo/lobaoo/AnimationPlayer
@onready var follow: PathFollow3D = $Path3D/PathFollow3D
@onready var cooldown_attack: Timer = %"espera ataque"
enum estado {ANDANDO,ATAQUE,MORTO}
var state = estado.ANDANDO


func _process(delta: float) -> void:
	match state:
		estado.ANDANDO:
			anim.play("Walk")
			follow.progress += delta
		estado.ATAQUE:
			pass
		estado.MORTO:
			pass

func _on_area_3d_body_entered(body: Node3D)-> void:
	if body.is_in_group("Player") and vida >= 1:
		state = estado.ATAQUE
		attack()
		



func attack():
	if state ==estado.ATAQUE:
		anim.play("Attack")
		await get_tree().create_timer(0.4).timeout
		GameManager.player["vida"] -= 1
		await get_tree().create_timer(0.1).timeout
		attack()


func _on_cooldown_attack_timeout() -> void:
	cooldown = true


func _on_area_3d_area_exited(area: Node3D) -> void:
	state= estado.ANDANDO
	print(123)
