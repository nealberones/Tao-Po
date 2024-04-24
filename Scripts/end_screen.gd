extends Node2D
@onready var finalscore = $HBoxContainer/Score
@onready var finalresult = $Score2
@onready var losemusic = $LoseMusicPlayer
@onready var winmusic = $WinMusicPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	finalscore.text = str(GameGlobalSingleton.total_score)
	if GameGlobalSingleton.total_score > 1000:
		finalresult.text = "You won the election! You are on the road to representing, hearing, and serving the members of your community!"
		winmusic.play()
	else:
		finalresult.text = "Unfortunately, you lost the elections. Though you didn't emerge victorious, your dedication and sportsmanship are commendable. Remember, every experience is a stepping stone towards success. Stay engaged and continue to make a positive impact in your community!"
		losemusic.play()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#determine final description based on score

func _on_exit_to_menu_pressed():
	GameGlobalSingleton.total_score = 0
	GameGlobalSingleton.l1_score = 0
	GameGlobalSingleton.l2_score = 0
	GameGlobalSingleton.l3_score = 0
	GameGlobalSingleton.exit_to_menu()
	Engine.time_scale = 1
	
func _on_quit_game_pressed():
	get_tree().quit()
