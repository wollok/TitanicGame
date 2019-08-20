import wollok.game.*

// Este objeto esta para cargar mas facil la config en la consola
object pelicula
{
	method inicio()
	{
		game.title("TitanicGame")
		game.height(10)
		game.width(10)
		game.ground("blue.jpg")

		game.addVisual(titanic)
		game.addVisual(iceberg)
	
		game.start()
	}
}

object titanic{
	var property imagen = "titanic.png"
	var property position = game.origin()
	
	method image() = imagen
	
	method golpeate(){
		imagen = "titanic-hundiendo.jpg"
	}
	
	// --- Movimiento --- //
	
	method irArriba(){
		self.position(self.position().up(1))
	}
	
	method irAbajo(){
		self.position(self.position().down(1))
	}
	
	method irIzquierda(){
		self.position(self.position().left(1))
	}
		
	method irDerecha(){
		self.position(self.position().right(1))
	}	
}


object iceberg{
	
	var property position = game.at(8,4)
	
	method image() = "iceberg.jpeg"
	
	method acercarse(){
		self.position(self.position().left(1))
	}
	
	method chocar(){
		titanic.golpeate()
	}
}