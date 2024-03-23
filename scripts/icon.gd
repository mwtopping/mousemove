extends Sprite2D

var rot_speed = randf_range(-0.1, 0.1)

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Hello, I'm ", name)
	
	
	print(self.rot_speed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate(self.rot_speed)



func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			self.rot_speed *= 2
			print("Mouse clicked")
		else:
			self.rot_speed /= 2
			print("Mouse unclicked")
