extends Sprite2D

var rot_speed = 0
var velocity = Vector2(0, 0)
var acceleration = Vector2(0, 0)
var drag = 1
var max_speed = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Hello, I'm ", name)
	print(self.rot_speed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):


	if Input.is_mouse_button_pressed(1):
			var direction = (get_viewport().get_mouse_position()-
							self.position).normalized()
			var speed = pow((get_viewport().get_mouse_position()-
							self.position).length(), 1.8)
			self.acceleration = speed*direction

			var angle = (get_viewport().get_mouse_position()-self.position).angle()

			
			self.rotation = angle+PI/2
			
	velocity += acceleration*delta
	
	if velocity.length() > self.max_speed:
		velocity = self.max_speed*velocity.normalized()


	position += velocity*delta
	velocity *= drag
func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			self.drag = 1.0
		else:
			self.drag = 0.97
			self.acceleration = Vector2(0, 0)
	
		
