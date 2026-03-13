extends TextEdit

func _process(delta: float) -> void:
	text = "Vida" + str(GameManager.player["vida"])
