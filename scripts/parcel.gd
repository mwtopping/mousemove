extends Polygon2D

var locPos = Vector2(0.0, 0.0)
var dist = remap(randf(), 0, 1, 0.5, 1)
var is_jumping = false
var jump_point = Vector2(0,0)
var jump_speed = 0
var is_target = false
# Called when the node enters the scene tree for the first time.
func _ready():
	self.scale *= (1-dist)+0.2
	self.locPos.x = 5000*(randf()-0.5)
	self.locPos.y = 5000*(randf()-0.5)
	self.position = locPos
	
	self.add_to_group("stars")

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
		self.jump_speed = pow(self.jump_speed, 1.05)


func go_away(center, speed, is_target):
	self.jump_speed = speed
	self.jump_point = center
	self.is_target = is_target
	if self.is_target == false:
		self.is_jumping = true


	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 2.0
	timer.one_shot = true
	timer.start()
	timer.connect("timeout", _on_timer_timeout)
	
	
	
func _on_timer_timeout():
	if self.is_target == true:
		get_parent().system.queue_free()
		get_parent().create_new_stars()
	queue_free()

