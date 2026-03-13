extends Area3D

func entrou (objeto: Node3D):
	if objeto.is_in_group("Player"):
		GameManager.voltar_posicao(objeto)
		GameManager.player["vida"] -= 1
