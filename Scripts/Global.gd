extends Node2D


var initGrow = false
var title = false

var bestScores = {
	"1": 999,
	"2": 999,
	"3": 999,
	"4": 999,
	"5": 999,
	"6": 999,
	"7": 999,
	"8": 999,
	"9": 999,
	"10": 999,
	"11": 999,
	"12": 999,
	"13": 999,
	"14": 999,
	"15": 999,
	"16": 999,
	"17": 999,
	"18": 999,
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func onTitle():
	print ("ON")
	self.get_node("AudioStreamPlayer").stop()
	self.get_node("TitleSong").play()

func offTitle():
	print ("OFF")
	self.get_node("TitleSong").stop()
	self.get_node("AudioStreamPlayer").play()


func playWinSound():
	self.get_node("AudioStreamPlayer").stop()
	self.get_node("TitleSong").stop()
	self.get_node("win").stop()
	self.get_node("win").play()


func _on_win_finished():
	if title:
		self.get_node("TitleSong").play()
	else:
		self.get_node("AudioStreamPlayer").play()
