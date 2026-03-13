extends Node

class_name GameManager
static  var player ={
	"vida": 3,
	"pos x": 0,
	"pos y": 0,
	"pos z": 0,
}

static func voltar_posicao(Player: Node3D):
	Player.global_position.x = player["pos x"]
	Player.global_position.y = player["pos y"]
	Player.global_position.z = player["pos z"]
