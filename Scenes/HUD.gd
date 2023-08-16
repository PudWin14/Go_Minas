extends CanvasLayer


signal new_game_pressed


func update_hud():
	$HContainer/LabelContainer/ColsNum.text = "Cols: " + str(GlobalVariables.new_max_cols)
	$HContainer/LabelContainer/RowsNum.text = "Rows: " + str(GlobalVariables.new_max_rows)
	$HContainer/LabelContainer/MinesNum.text = "Number of Mines: " + str(GlobalVariables.new_num_mines)


func _on_plus_row_button_pressed():
	GlobalVariables.new_max_rows += 1
	update_hud()
func _on_minus_row_button_pressed():
	GlobalVariables.new_max_rows -= 1
	update_hud()


func _on_plus_col_button_pressed():
	GlobalVariables.new_max_cols += 1
	update_hud()
func _on_minus_col_button_pressed():
	GlobalVariables.new_max_cols -= 1
	update_hud()


func _on_plus_mine_button_pressed():
	GlobalVariables.new_num_mines += 1
	update_hud()
func _on_minus_mine_button_pressed():
	GlobalVariables.new_num_mines -= 1
	update_hud()


func _on_new_game_button_pressed():
	new_game_pressed.emit()
