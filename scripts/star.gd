extends Polygon2D

var radius = 100
var npoints = 64
var planetobj = load("res://Scenes/planet.tscn")
var nplanets = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	var data = PackedVector2Array()
	for ii in range(npoints):
		var x = self.radius * sin(2*PI*float(ii)/npoints)
		var y = self.radius * cos(2*PI*float(ii)/npoints)
		data.append(Vector2(x, y))
	self.polygon = data
	self.color = Color(1, 1, .2)
	
	for ii in range(nplanets):
		var planet = planetobj.instantiate()
		add_child(planet)




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
