extends Control

func _ready():
	get_tree().paused = false

func _on_easy_button_pressed():
	GlobalVariables.new_max_cols = 9
	GlobalVariables.new_max_rows = 9
	GlobalVariables.new_num_mines = 10
	GlobalVariables.new_game()
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_normal_button_pressed():
	GlobalVariables.new_max_cols = 16
	GlobalVariables.new_max_rows = 16
	GlobalVariables.new_num_mines = 40
	GlobalVariables.new_game()
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_hard_button_pressed():
	GlobalVariables.new_max_cols = 30
	GlobalVariables.new_max_rows = 16
	GlobalVariables.new_num_mines = 99
	GlobalVariables.new_game()
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_custom_button_pressed():
	GlobalVariables.new_max_cols = 9
	GlobalVariables.new_max_rows = 9
	GlobalVariables.new_num_mines = 10
	GlobalVariables.new_game()
	GlobalVariables.custom = true
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_exit_button_pressed():
	get_tree().quit()
