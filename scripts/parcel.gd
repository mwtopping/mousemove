extends Polygon2D

var locPos = Vector2(0.0, 0.0)
var dist = remap(randf(), 0, 1, 0.5, 1)
var is_jumping = false
var jump_point = Vector2(0,0)
var jump_speed = 0
var is_target = false
var is_approaching = false
var left_position 
var fading = true
# Called when the node enters the scene tree for the first time.
func _ready():
	self.scale *= (1-dist)+0.2
	self.locPos.x = 5000*(randf()-0.5)
	self.locPos.y = 5000*(randf()-0.5)
	self.position = locPos
	self.color = Color(1, 1, 1, 0)

	self.add_to_group("stars")

	
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1.0
	timer.one_shot = true
	timer.start()
	timer.connect("timeout", _on_star_fadein_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#self.position.x += randf()-0.5
	#self.position.y += randf()-0.5
	var parent = get_parent()
	var player = parent.get_node("Icon2")
	var camera = player.get_node("Camera")
	self.position = self.locPos + dist*camera.get_screen_center_position()
	#self.position = self.locPos
	if is_jumping:
		
		var direction = self.jump_speed*((self.global_position - self.jump_point).normalized())
		self.locPos += direction
		self.jump_speed = pow(self.jump_speed, 1.03)


			
	if is_approaching:
		self.locPos += (0.2*delta)*camera.get_screen_center_position()
		self.dist -= 0.2*delta
		

		#var direction = 0.1*self.jump_speed*((self.global_position - self.jump_point).normalized())
		#self.locPos += direction
		
	if fading:
		self.color.a += delta
		
		
func go_away(center, speed, is_target):
	self.jump_speed = speed
	self.jump_point = center
	self.is_target = is_target
	self.left_position = self.locPos
	if self.is_target == false:
		if self.dist < 0.7:
			self.is_jumping = true
			print(self.dist)
		else:
			print("LKHWER")
			self.is_approaching = true
	


	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1.0
	timer.one_shot = true
	timer.start()
	timer.connect("timeout", _on_timer_timeout)
	
	
	
func _on_timer_timeout():
	if self.is_target == true:
		get_parent().system.queue_free()
		get_parent().create_new_stars(self.global_position)
		get_parent().get_node("Icon2").reset_reticule()
		self.destroy_and_replace()
	if self.is_jumping == true:
		self.destroy_and_replace()
	if self.is_approaching == true:
		self.is_approaching = false
		print(self.dist)
		self.scale = Vector2(1.0, 1.0)*((1-dist)+0.2)
		if self.dist < 0.7:
			self.add_to_group("stars")
			print(self.dist)
		
func destroy_and_replace():
	get_parent().create_one_star()
	queue_free()
	
func _on_star_fadein_timeout():
	self.fading = false
