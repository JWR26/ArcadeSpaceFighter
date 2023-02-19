extends VBoxContainer

var final_score: int = 0
var displayed_score: int = 0
var new_high_score: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$FinalScore/Score.text = str(displayed_score)
	final_score = HighScoreManager.current_score
	new_high_score = HighScoreManager.is_new_high_score(final_score)
	# play high score animation
	if new_high_score:
		new_high_score()
		$MarginContainer/LineEdit.grab_focus()


func _physics_process(delta: float) -> void:
	# increase the displayed score old school counter style
	if (displayed_score < final_score):
		displayed_score += 10
		$FinalScore/Score.text = str(displayed_score)


func new_high_score() -> void:
	$AnimationPlayer.play("HighScore")
	$AnimationPlayer.queue("HighScoreFlash")


func _on_LineEdit_text_entered(new_text: String) -> void:
	$MarginContainer/LineEdit.set_editable(false)

	if new_high_score:
		HighScoreManager.add_high_score(final_score, new_text)

	SceneChanger.change_scene("res://menu/main_menu.tscn", 0)
