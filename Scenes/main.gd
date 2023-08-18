extends Node

var CellScene = preload("res://Scenes/cell.tscn")
var status_grid = []

signal click_cell_main(pos : Vector2)

func _ready():
	
	display_cells(GlobalVariables.MAX_ROWS,GlobalVariables.MAX_COLS)
	# Create a grid of status of cells. 1 if cover. 0 if uncover
	status_grid = new_status_grid()
	$HUD.new_game_pressed.connect(restart_game)



func end_game():
#	print("Game Overrr")
	
	$MessageLabel.text = "Game Over!!"
	$MessageLabel.show()
	
#	restart_game()
	get_tree().paused = true


func click_around_cells(cell : Vector2):
#	print(positions)
	var positions = GlobalVariables.find_around_cells(cell)
	for pos in positions:
		if not status_grid[pos.x][pos.y]:
			pass
		else :
			click_cell_main.emit(pos)



func click_free_cell(pos):
	uncover_cell(pos)
	if win_check():
#		restart_game()
		get_tree().paused = true
		
	

func uncover_cell(pos:Vector2):
	status_grid[pos.x][pos.y] = 0

func win_check():
	var total_uncovered = 0
	for row in GlobalVariables.MAX_ROWS:
		for col in GlobalVariables.MAX_COLS:
			total_uncovered += status_grid[row][col]
	
	if total_uncovered == GlobalVariables.NUM_MINES:
		$MessageLabel.text = "WIN!!!!"
		$MessageLabel.show()
		return true
	return false


func display_cells(num_rows,num_cols):
	
	$CellsGrid.columns = num_cols
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
			
			$CellsGrid.add_child(new_cell)


func delate_cells():
	for child in $CellsGrid.get_children():
		child.queue_free()

func new_game():
	GlobalVariables.new_game()
	status_grid = new_status_grid()
	$CellsGrid.hide()
	delate_cells()
	display_cells(GlobalVariables.MAX_ROWS,GlobalVariables.MAX_COLS)
	await get_tree().create_timer(0.15).timeout
	$CellsGrid.show()

func new_status_grid():
	var new_status_grid = []
	for row in range(GlobalVariables.MAX_ROWS):
		new_status_grid.append([])
		new_status_grid[row].resize(GlobalVariables.MAX_COLS)
		new_status_grid[row].fill(1)
		
	return new_status_grid



func restart_game():
	get_tree().paused = false
	
	$MessageLabel.hide()
	new_game()




