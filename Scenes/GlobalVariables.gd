extends Node

# Constants
var MAX_ROWS = 9
var MAX_COLS = 9
var NUM_MINES = 10

var new_max_rows = MAX_ROWS
var new_max_cols = MAX_COLS
var new_num_mines = NUM_MINES

#var cells_grid = [[1,0,0,0,0,0],[1,0,0,0,0,0],[1,0,0,0,0,0],[1,0,0,0,0,0],[1,0,0,0,0,0]]
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
	
	var register = []
	for mine in range(num_mines):
		
		if mine >= (num_rows * num_cols)-1:
			break
		
		var success = false
		while not success:
			var row = randi() % num_rows
			var col = randi() % num_cols
			
			if register.find([row,col]) != -1:
				continue
			
			if not grid[row][col]:
				grid[row][col] = 1
				success = true
				register.append([row,col])
	
	return grid
