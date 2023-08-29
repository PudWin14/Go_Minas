extends TextureButton

@export var row : int
@export var col : int

var MAX_ROWS = GlobalVariables.MAX_ROWS
var MAX_COLS = GlobalVariables.MAX_COLS

#Status:
#	0 -> Explored Cell
#	1 -> Unexplored Cell
#	2 -> Flag Cell
var status = 1

signal game_over
signal click(pos:Vector2)
signal click_around(pos : Vector2)


# Called when the node enters the scene tree for the first time.
func _ready():
#	print("row:",row," col:",col)
	pass

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
		print("MIDDLE")



func click_cell_from_main(pos:Vector2):
	if (pos == Vector2(row,col)) and status:
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
			click.emit(Vector2(row,col))
			click_around.emit(Vector2(row,col))
		1:
			texture = GlobalVariables.texture1
			click.emit(Vector2(row,col))
		2:
			texture = GlobalVariables.texture2
			click.emit(Vector2(row,col))
		3:
			texture = GlobalVariables.texture3
			click.emit(Vector2(row,col))
		4:
			texture = GlobalVariables.texture4
			click.emit(Vector2(row,col))
		5:
			texture = GlobalVariables.texture5
			click.emit(Vector2(row,col))
		6:
			texture = GlobalVariables.texture6
			click.emit(Vector2(row,col))
		7:
			texture = GlobalVariables.texture7
			click.emit(Vector2(row,col))
		8:
			texture = GlobalVariables.texture8
			click.emit(Vector2(row,col))
	
	texture_disabled = texture
	
	disabled = true
