extends CanvasLayer


signal new_game_pressed

func _ready():
	if not GlobalVariables.custom:
		for button in $HContainer/MinusButtonContainer.get_children():
			button.hide()
		for button in $HContainer/PlusButtonContainer.get_children():
			button.hide()

func update_hud():
	$HContainer/LabelContainer/ColsNum.text = "Cols: " + str(GlobalVariables.new_max_cols)
	$HContainer/LabelContainer/RowsNum.text = "Rows: " + str(GlobalVariables.new_max_rows)
	$HContainer/LabelContainer/MinesNum.text = "Number of Mines: " + str(GlobalVariables.new_num_mines)


func _on_plus_row_button_pressed():
	GlobalVariables.new_max_rows += 1
	update_hud()
func _on_minus_row_button_pressed():
	if GlobalVariables.new_max_rows >2:
		GlobalVariables.new_max_rows -= 1
	update_hud()


func _on_plus_col_button_pressed():
	GlobalVariables.new_max_cols += 1
	update_hud()
func _on_minus_col_button_pressed():
	if GlobalVariables.new_max_cols >2:
		GlobalVariables.new_max_cols -= 1
	update_hud()


func _on_plus_mine_button_pressed():
	GlobalVariables.new_num_mines += 1
	update_hud()
func _on_minus_mine_button_pressed():
	if GlobalVariables.new_num_mines >1:
		GlobalVariables.new_num_mines -= 1
	update_hud()


func _on_new_game_button_pressed():
	new_game_pressed.emit()


func game_over():
	$MessageLabel.text = "Game Over!!"
	$MessageLabel.show()

func win():
	$MessageLabel.text = "WIN!!!!"
	$MessageLabel.show()

func hide_message():
	$MessageLabel.hide()


func update_time(time):
	$TimeLabel.text = str(time)

func update_remaining_mines(remainig):
	$RemainingLabel.text = "Mines Remainig: " + str(remainig)

func _on_back_btton_pressed():
	GlobalVariables.custom = false
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
