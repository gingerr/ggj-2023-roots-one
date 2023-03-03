class_name HighScore
extends Resource

static func getScore() -> int:
	return int(Utils.load_text_file("user://highscore.txt"))
	
static func setScore(value: int) -> void:
	Utils.save_text_file("user://highscore.txt", str(value))
