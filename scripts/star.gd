extends Polygon2D

var radius = 50+randf()*50
var npoints = 64
var planetobj = load("res://Scenes/planet.tscn")
var nplanets = randi_range(0, 9)
# Called when the node enters the scene tree for the first time.
func _ready():
	print("Star Ready")
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




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
