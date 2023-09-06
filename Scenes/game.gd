extends Node

var CellScene = preload("res://Scenes/cell.tscn")
var time

@onready var CellsGrid = get_node("CellsGrid")

signal click_cell_main(pos : Vector2)
signal win
signal lose

func _ready():
	display_cells(GlobalVariables.MAX_ROWS,GlobalVariables.MAX_COLS)
	time = 0
	
	$HUD.new_game_pressed.connect(restart_game)
	$HUD.update_hud()


func end_game():
	$Timer.stop()
	$HUD.game_over()
	
	lose.emit()
	
	get_tree().paused = true



func click_around_cells(cell : Vector2):
	
	var positions = GlobalVariables.find_around_cells(cell)
	for pos in positions:
		click_cell_main.emit(pos)


func click_free_cell():
	
	if $Timer.is_stopped():
		$Timer.start()
		time = 0
		$HUD.update_time(time)
	
	if win_check():
		$Timer.stop()
	


func win_check():
	var total_uncovered = 0
	
	for cell in CellsGrid.get_children():
		if cell.status:
			total_uncovered += 1
	
	if total_uncovered == GlobalVariables.NUM_MINES:
		$HUD.win()
		win.emit()
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
			new_cell.find_around_status.connect(find_status_around)
			
			click_cell_main.connect(new_cell.click_cell_from_main)
			win.connect(new_cell.win)
			lose.connect(new_cell.lose)
			
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


func find_status_around(pos: Vector2):
	var around_positions = GlobalVariables.find_around_cells(pos)
	var num_flags = 0
	
	for cell in $CellsGrid.get_children():
		
		if around_positions.find(cell.my_pos) == -1:
			continue
		
		if cell.status == 2:
			num_flags += 1
	
	if num_flags >= GlobalVariables.cells_grid[pos.x][pos.y]:
		click_around_cells(pos)
