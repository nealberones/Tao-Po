extends CanvasLayer

const CHAR_READ_RATE = 0.5

@onready var text_box_container = $TextBoxContainer
@onready var start = $TextBoxContainer/MarginContainer/HBoxContainer/Start
@onready var label = $TextBoxContainer/MarginContainer/HBoxContainer/Label
@onready var end = $TextBoxContainer/MarginContainer/HBoxContainer/End

enum State{
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var tween
var text_queue = [] 
# Called when the node enters the scene tree for the first time.

func _ready():
	hide_textbox()
	print("textbox ready")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match current_state:
		State.READY:
			if text_queue:
				display_text()
		State.READING:
			if Input.is_action_just_pressed("mouse_click"):
				label.visible_ratio = 1.0
				end.text = "v"
				tween.kill()
				change_state(State.FINISHED)
		State.FINISHED:
			if Input.is_action_just_pressed("mouse_click"):
				change_state(State.READY)
				hide_textbox()
				
	

func hide_textbox():
	label.text = ""
	start.text = ""
	end.text = ""
	text_box_container.hide()
	
func show_textbox():
	start.text = "*"
	text_box_container.show()

func display_text():
	var new_text = text_queue.pop_front()
	tween = get_tree().create_tween()
	label.text = new_text
	label.visible_ratio = 0.0
	change_state(State.READING)
	show_textbox()
	tween.tween_property(label,"visible_ratio", 1.0, 1).from(0.0).set_trans(Tween.TRANS_LINEAR)
	tween.connect("finished", on_tween_finished)
	
func on_tween_finished():
	end.text = "v"
	change_state(State.FINISHED)

#changes current state of text box
func change_state(new_state):
	current_state = new_state
	match current_state:
		State.READY:
			print("Changing state to State.READY")
		State.READING:
			print("Changing state to State.READING")
		State.FINISHED:
			print("Changing state to State.FINISHED")

#for queueing new text for text box
func queue_text(next_text):
	text_queue.push_back(next_text)

func get_state():
	match current_state:
		State.READY:
			return "ready"
		State.READING:
			return "reading"
		State.FINISHED:
			return "finished"

func is_empty():
	if len(text_queue) == 0:
		return true
	else:
		return false
