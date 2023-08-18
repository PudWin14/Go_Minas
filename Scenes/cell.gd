extends TextureButton

@export var row : int
@export var col : int

var MAX_ROWS = GlobalVariables.MAX_ROWS
var MAX_COLS = GlobalVariables.MAX_COLS

signal game_over
signal click(pos:Vector2)
signal click_around(pos : Vector2)

# Called when the node enters the scene tree for the first time.
func _ready():
#	print("row:",row," col:",col)
	pass


func _on_toggled(_button_pressed):
	if Input.is_action_just_released("left_click"):
#		print("LEFT")
		click_cell()
		
	if Input.is_action_just_released("right_click"):
		print("RIGHT")
	if Input.is_action_just_released("middle_click"):
		print("MIDDLE")



func click_cell_from_main(pos:Vector2):
	if pos == Vector2(row,col):
		click_cell()
	else:
		pass

func click_cell():
	var is_mine = GlobalVariables.cells_grid[row][col]
	var texture
	var around_mines = count_mines(Vector2(row,col))
	
	if not is_mine:
		click.emit(Vector2(row,col))
		match around_mines:
			0:
				texture = GlobalVariables.texture0
				click_around.emit(Vector2(row,col))
			1:
				texture = GlobalVariables.texture1
			2:
				texture = GlobalVariables.texture2
			3:
				texture = GlobalVariables.texture3
			4:
				texture = GlobalVariables.texture4
			5:
				texture = GlobalVariables.texture5
			6:
				texture = GlobalVariables.texture6
			7:
				texture = GlobalVariables.texture7
			8:
				texture = GlobalVariables.texture8
				
	else:
		texture = GlobalVariables.texture_mine_hit
		game_over.emit()
	
	texture_disabled = texture
	
	disabled = true
#	print(row,col," : ",$"../..".find_around_cells(Vector2(row,col)))



func count_mines(actual_pos:Vector2):
	var total_mines = 0
	var index_x = [actual_pos.x-1,actual_pos.x,actual_pos.x+1]
	var index_y = [actual_pos.y-1,actual_pos.y,actual_pos.y+1]
	
	for i in index_x:
		if (i >=0) and (i < MAX_ROWS):
			for j in index_y:
				if (j >=0) and (j < MAX_COLS):
					total_mines += GlobalVariables.cells_grid[i][j]
	return total_mines
