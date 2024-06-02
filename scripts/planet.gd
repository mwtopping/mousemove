extends Polygon2D

var radius = randf()*30+10
var npoints = 64
var semi_major_axis = radius+1+100+randf()*2000
var phi = randf()*2*PI
var orbitmodel = load("res://Scenes/orbit.tscn")
var orbit
# Called when the node enters the scene tree for the first time.
func _ready():
	var data = PackedVector2Array()
	for ii in range(npoints):
		var x = self.radius * sin(2*PI*float(ii)/npoints)
		var y = self.radius * cos(2*PI*float(ii)/npoints)
		data.append(Vector2(x, y))
	self.polygon = data
	self.color = Color(.5, .3, .2)
	
	self.position = Vector2(self.semi_major_axis*sin(2*PI*self.phi), self.semi_major_axis*cos(2*PI*self.phi))
	
	self.orbit = orbitmodel.instantiate()
	var orbitdata = PackedVector2Array()
	for jj in range(4*npoints):
		var ox = self.semi_major_axis*sin(self.phi+2*PI*jj/npoints/4)-self.position.x
		var oy = self.semi_major_axis*cos(self.phi+2*PI*jj/npoints/4)-self.position.y
		orbitdata.append(Vector2(ox, oy))
		
	self.orbit.points = orbitdata
	self.orbit.closed = true
	self.orbit.width = 2.0
	self.orbit.antialiased=true
	
	var grad_data = {0.0: Color.BLACK, 0.2:Color.BLACK, 1.0: Color.WHITE}
	var grad = Gradient.new()
	grad.offsets = grad_data.keys()
	grad.colors = grad_data.values()
	
	self.orbit.gradient = grad
	#self.orbit.Color = Color(1, 1, 1, 1)

	add_child(self.orbit)
		
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.phi += 1000*delta/pow(self.semi_major_axis, 1.5)
	self.position = Vector2(self.semi_major_axis*sin(2*PI*self.phi), 
								self.semi_major_axis*cos(2*PI*self.phi))



	var orbitdata = PackedVector2Array()
	for jj in range(4*npoints):
		var ox = self.semi_major_axis*sin(2*PI*(self.phi+float(jj)/npoints/4))-self.position.x
		var oy = self.semi_major_axis*cos(2*PI*(self.phi+float(jj)/npoints/4))-self.position.y
		orbitdata.append(Vector2(ox, oy))
			
	
	get_node("orbit").points = orbitdata
	
