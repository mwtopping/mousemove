extends Node2D


var spawnobj = load("res://Scenes/parcel.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for n in range(1000):
		var tmp = spawnobj.instantiate()
		add_child(tmp)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
