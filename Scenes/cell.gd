extends TextureButton

@export var row : int
@export var col : int
@onready var my_pos = Vector2(row,col)

var MAX_ROWS = GlobalVariables.MAX_ROWS
var MAX_COLS = GlobalVariables.MAX_COLS

#Status:
#	0 -> Explored Cell
#	1 -> Unexplored Cell
#	2 -> Flag Cell
var status = 1

signal game_over
signal click()
signal click_around(pos : Vector2)
signal find_around_status(positions : Vector2)


func _process(delta):
	match status:
		1:
			texture_normal = GlobalVariables.texture_uncovered
		2:
			texture_normal = GlobalVariables.texture_flag

func _on_toggled(_button_pressed):
	if Input.is_action_just_released("left_click"):
		if status == 1:
			click_cell()
		
	if Input.is_action_just_released("right_click"):
		if status == 1:
			status = 2
		elif  status == 2:
			status = 1
		
	if Input.is_action_just_released("middle_click"):
		if not status:
			clear_around()



func click_cell_from_main(pos:Vector2):
	if (pos == my_pos) and (status == 1):
		click_cell()
	else:
		pass

func click_cell():
	var is_mine = GlobalVariables.cells_grid[row][col]
	var texture
	status = 0
	
	match is_mine:
		-1:
			texture = GlobalVariables.texture_mine_hit
			game_over.emit()
		0:
			texture = GlobalVariables.texture0
			click.emit()
			click_around.emit(my_pos)
		1:
			texture = GlobalVariables.texture1
			click.emit()
		2:
			texture = GlobalVariables.texture2
			click.emit()
		3:
			texture = GlobalVariables.texture3
			click.emit()
		4:
			texture = GlobalVariables.texture4
			click.emit()
		5:
			texture = GlobalVariables.texture5
			click.emit()
		6:
			texture = GlobalVariables.texture6
			click.emit()
		7:
			texture = GlobalVariables.texture7
			click.emit()
		8:
			texture = GlobalVariables.texture8
			click.emit()
	
	texture_normal = texture


func clear_around():
	find_around_status.emit(my_pos)


func win():
	if status == 1:
		status = 2
		texture_normal = GlobalVariables.texture_flag

func lose():
	if (status == 1) and (GlobalVariables.cells_grid[row][col] <0):
		texture_normal = GlobalVariables.texture_mine
