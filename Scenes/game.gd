extends Node

var CellScene = preload("res://Scenes/cell.tscn")
var time

@onready var CellsGrid = get_node("CellsGrid")

signal click_cell_main(pos : Vector2)

func _ready():
	
	display_cells(GlobalVariables.MAX_ROWS,GlobalVariables.MAX_COLS)
	time = 0
	
	$HUD.new_game_pressed.connect(restart_game)
	$HUD.update_hud()


func end_game():
	get_tree().paused = true
	$Timer.stop()
	$HUD.game_over()


func click_around_cells(cell : Vector2):
	
	var positions = GlobalVariables.find_around_cells(cell)
	for pos in positions:
		click_cell_main.emit(pos)


func click_free_cell(pos):
	
	if $Timer.is_stopped():
		$Timer.start()
		time = 0
		$HUD.update_time(time)
	
#	uncover_cell(pos)
	if win_check():
#		restart_game()
		get_tree().paused = true
		
	


func win_check():
	var total_uncovered = 0
	
	for cell in CellsGrid.get_children():
		if cell.status ==1:
			total_uncovered += 1
	
	if total_uncovered == GlobalVariables.NUM_MINES:
		$HUD.win()
		return true
	return false


func display_cells(num_rows,num_cols):
	
	CellsGrid.columns = num_cols
	CellsGrid.size = Vector2(24*num_cols,24*num_rows)
	
	for row in num_rows:
		for col in num_cols:
			var new_cell = CellScene.instantiate()
			new_cell.row = row
			new_cell.col = col
			
			# Conect all the cells to ear the signals
			new_cell.game_over.connect(end_game)
			new_cell.click.connect(click_free_cell)
			new_cell.click_around.connect(click_around_cells)
			click_cell_main.connect(new_cell.click_cell_from_main)
			
			CellsGrid.add_child(new_cell)



func delate_cells():
	for child in CellsGrid.get_children():
		child.queue_free()

func new_game():
	GlobalVariables.new_game()
	CellsGrid.hide()
	delate_cells()
	display_cells(GlobalVariables.MAX_ROWS,GlobalVariables.MAX_COLS)
	time = 0
	$Timer.stop()
	$HUD.update_time(time)
	CellsGrid.show()



func restart_game():
	get_tree().paused = false
	
	$HUD.hide_message()
	new_game()



func _on_timer_timeout():
	time += 1
	$HUD.update_time(time)
