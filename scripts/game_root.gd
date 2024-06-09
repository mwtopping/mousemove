extends Node2D


var spawnobj = load("res://Scenes/parcel.tscn")
var star = load("res://Scenes/star.tscn")
var system

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for n in range(1000):
		var tmp = spawnobj.instantiate()
		add_child(tmp)
	print("Starting Star Instantiation")
	self.system = star.instantiate()
	add_child(self.system)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _input(event):
	if event is InputEventKey:
		if event.keycode == KEY_X and event.pressed:
			self.system.call_deferred("free")
			
			self.system = star.instantiate()
			add_child(self.system)
			


func create_new_stars():
	for n in range(1000):
		var tmp = spawnobj.instantiate()
		add_child(tmp)
	print("Starting Star Instantiation")
	self.system = star.instantiate()
	add_child(self.system)
