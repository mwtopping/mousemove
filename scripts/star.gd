extends Polygon2D

var radius = 50+randf()*50
var npoints = 64
var planetobj = load("res://Scenes/planet.tscn")
var nplanets = randi_range(0, 9)
var is_jumping = false
var jump_point = Vector2(0,0)
var jump_speed = 0
var is_growing = true

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Star Ready")
	self.scale = Vector2(0.0, 0.0)
	self.position = Vector2(0.0, 0.0)
	var data = PackedVector2Array()
	for ii in range(npoints):
		var x = self.radius * sin(2*PI*float(ii)/npoints)
		var y = self.radius * cos(2*PI*float(ii)/npoints)
		data.append(Vector2(x, y))
	self.polygon = data
	var colorgrad = load("res://Gradients/starcolors.tres")

	self.color = colorgrad.sample(randf())
	
	for ii in range(nplanets):
		var planet = planetobj.instantiate()
		add_child(planet)

	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 0.5
	timer.one_shot = true
	timer.start()
	timer.connect("timeout", _on_star_growing_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_jumping:
		var direction = self.jump_speed*((self.global_position - self.jump_point).normalized())
		self.position += direction
		self.jump_speed = pow(self.jump_speed, 1.03)
		#self.scale += Vector2(0.01, 0.01)
	if self.is_growing:
		self.scale += Vector2(2*delta, 2*delta)

func go_away(center, speed):
	self.jump_speed = speed
	self.jump_point = center
	self.is_jumping = true


	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 2.0
	timer.one_shot = true
	timer.start()
	timer.connect("timeout", _on_timer_timeout)
	
	
	
func _on_timer_timeout():
	queue_free()


func _on_star_growing_timeout():
	self.is_growing = false
