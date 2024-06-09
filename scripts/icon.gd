extends Sprite2D

var rot_speed = 0
var velocity = Vector2(0, 0)
var acceleration = Vector2(0, 0)
var drag = 1
var max_speed = 350
var rocket
var boost
var sprite
var jump_target
var closest = null
var camera
var reticule
#var spawnobj = load("res://Scenes/parcel.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Hello, I'm ", name)
	print(self.rot_speed)
	self.jump_target = get_node("targeting")
	self.jump_target.default_color = Color(0.8, 0.8, 0.8)
	self.camera = get_node("Camera")
	self.reticule = get_node("reticule")
	self.reticule.visible = false
	#for n in range(100):
		#var tmp = spawnobj.instantiate()
		#tmp.position.x = 1000*(randf()-0.5)
		#tmp.position.y = 1000*(randf()-0.5)
		#add_child(tmp)
		
	print(self.scale)


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
	

			
			

	if closest != null:
		var _points = PackedVector2Array()
		_points.append(Vector2(0, 0))
		var endpoint = (self.closest.global_position-self.global_position)/self.scale
		self.reticule.position = endpoint
		endpoint = (endpoint.length()-50)*endpoint.normalized()
		self.reticule.visible = true



		if endpoint.length() > 2000:
			self.closest = null
			self.reticule.visible = false
			endpoint = Vector2(0, 0)
			
		_points.append(endpoint)
		self.jump_target.points = _points			
	
func _input(event):
	if event is InputEventKey:
		if event.keycode == KEY_MINUS:
			get_node("Camera").zoom *= 0.9
		if event.keycode == KEY_EQUAL:
			get_node("Camera").zoom *= 1.1
			
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_LEFT:
				self.drag = 1.0
				get_node("sprite/rocket").emitting=true
			if event.button_index == MOUSE_BUTTON_RIGHT and Input.is_mouse_button_pressed(1):
				get_node("sprite/boost").emitting=true
				self.max_speed = 650
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
				
				
	if event is InputEventKey:
		if event.keycode == KEY_Z and event.pressed:
			
			var mindist = 999999999
			var allstars = get_tree().get_nodes_in_group("stars")
			for s in allstars:
				
				var _dist = (self.global_position - s.global_position).length()

				if _dist < mindist:
					mindist = _dist
					self.closest = s
					

		if event.keycode == KEY_SPACE and event.pressed:
			if self.closest != null:
				var allstars = get_tree().get_nodes_in_group("stars")
				for s in allstars:
					if s == self.closest:
						s.go_away(self.closest.global_position, 2, true)
					else: 
						s.go_away(self.closest.global_position, 2, false)
				
