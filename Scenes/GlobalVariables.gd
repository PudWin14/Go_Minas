extends Node

# Constants
var MAX_ROWS = 9
var MAX_COLS = 9
var NUM_MINES = 10

var new_max_rows = MAX_ROWS
var new_max_cols = MAX_COLS
var new_num_mines = NUM_MINES

var cells_grid = create_grid(MAX_ROWS,MAX_COLS,NUM_MINES)

var texture0 = load("res://Assets/Minesweeper_LAZARUS_21x21_0.png")
var texture1 = load("res://Assets/Minesweeper_LAZARUS_21x21_1.png")
var texture2 = load("res://Assets/Minesweeper_LAZARUS_21x21_2.png")
var texture3 = load("res://Assets/Minesweeper_LAZARUS_21x21_3.png")
var texture4 = load("res://Assets/Minesweeper_LAZARUS_21x21_4.png")
var texture5 = load("res://Assets/Minesweeper_LAZARUS_21x21_5.png")
var texture6 = load("res://Assets/Minesweeper_LAZARUS_21x21_6.png")
var texture7 = load("res://Assets/Minesweeper_LAZARUS_21x21_7.png")
var texture8 = load("res://Assets/Minesweeper_LAZARUS_21x21_8.png")

var texture_mine = load("res://Assets/Minesweeper_LAZARUS_21x21_mine.png")
var texture_mine_hit = load("res://Assets/Minesweeper_LAZARUS_21x21_mine_hit.png")

var texture_flag = load("res://Assets/Minesweeper_LAZARUS_21x21_flag.png")
var texture_uncovered = load("res://Assets/Minesweeper_LAZARUS_21x21_unexplored.png")


func _ready():
#	print(cells_grid)
	pass

func new_game():
	MAX_ROWS = new_max_rows
	MAX_COLS = new_max_cols
	NUM_MINES = new_num_mines
	cells_grid = create_grid(MAX_ROWS,MAX_COLS,NUM_MINES)

func create_grid(num_rows, num_cols, num_mines):
	var grid = []
	for row in range(num_rows):
		grid.append([])
		grid[row].resize(num_cols)
		grid[row].fill(0)
	
	
	for mine in range(num_mines):
		
		if mine >= (num_rows * num_cols)-1:
			NUM_MINES -=1
			break
		
		var success = false
		while not success:
			var row = randi() % num_rows
			var col = randi() % num_cols
			
			if grid[row][col] >= 0:
				grid[row][col] = -1
				success = true
				var around_positions = find_around_cells(Vector2(row,col))
				
				for pos in around_positions:
					if grid[pos.x][pos.y] >=0:
						grid[pos.x][pos.y] += 1
	
	return grid


func find_around_cells(pos:Vector2):
	var around_cells = []
	
	for i in [-1,0,1]:
		for j in [-1,0,1]:
			if i or j:
				if (pos.x+i < 0) or (pos.x+i >= MAX_ROWS):
					pass
				elif ( pos.y+j < 0) or (pos.y+j >= MAX_COLS):
					pass
				else:
					around_cells.append(pos + Vector2(i,j))
	
	return around_cells
