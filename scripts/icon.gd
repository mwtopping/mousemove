extends Sprite2D

var rot_speed = 0
var velocity = Vector2(0, 0)
var acceleration = Vector2(0, 0)
var drag = 1
var max_speed = 350
var rocket
var boost
var sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Hello, I'm ", name)
	print(self.rot_speed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):


	if Input.is_mouse_button_pressed(1):
			var direction = (get_global_mouse_position()-
							self.position).normalized()
			var speed = pow((get_global_mouse_position()-
							self.position).length(), 1.8)
#			var direction = (get_viewport().get_mouse_position()-
#							self.position).normalized()
#			var speed = pow((get_viewport().get_mouse_position()-
#							self.position).length(), 1.8)
			self.acceleration = speed*direction

			var angle = (get_global_mouse_position()-self.position).angle()
			
			#self.rotation = angle+PI/2
			get_node("sprite").rotation = angle+PI/2
			get_node("sprite/rocket").rotation = angle+PI/2
	velocity += acceleration*delta
	
	if velocity.length() > self.max_speed:
		velocity = self.max_speed*velocity.normalized()


	position += velocity*delta
	velocity *= drag
func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_LEFT:
				self.drag = 1.0
				get_node("sprite/rocket").emitting=true
			if event.button_index == MOUSE_BUTTON_RIGHT and Input.is_mouse_button_pressed(1):
				get_node("sprite/boost").emitting=true
				self.max_speed = 500
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				get_node("Camera").zoom *= 1.1
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				get_node("Camera").zoom *= 0.9
		else:
			if event.button_index == MOUSE_BUTTON_LEFT:
				self.drag = 0.97
				self.acceleration = Vector2(0, 0)
				get_node("sprite/rocket").emitting=false
				get_node("sprite/boost").emitting=false
				self.max_speed = 350
			if event.button_index == MOUSE_BUTTON_RIGHT:	
				get_node("sprite/boost").emitting=false
				self.max_speed = 350
		
