import wollok.game.*

// Este objeto esta para cargar mas facil la config en la consola
object pelicula
{
	method inicio()
	{
		game.title("TitanicGame")
		game.height(7)
		game.width(7)
		game.ground("blue.jpg")

		game.addVisual(titanic)
		game.addVisual(iceberg)
		game.addVisual(capitan)
		game.addVisual(barcoPesquero)
	
		game.start()
	}
}

object barcoPesquero{
	var imagen = "pesquero.png"
	var position = game.at(1,1)
	
	method image() { return imagen}
	method position() { return position}
	
	method hundite(){
		imagen = "pesquero-hundido.jpg"
	} 
	
	method chocar(){
		titanic.hundite()
		capitan.morite()
		barcoPesquero.hundite()
	}
}

object titanic{
	var imagen = "titanic.png"
	var position = game.at(2,2)
	var hundido = false
	
	method image() { return imagen}
	method position() { return position}
	
	method puedeFlotar() {
		return !hundido
	}
	
	method hundite(){
		imagen = "titanic-hundiendo.jpg"
		hundido = true
	//	game.addVisual(puerta) -- Aca rompe y no rompe, nose porqe
	}
}	



object capitan{
	var image = "capitan.jpeg"
	var vida = 100
	
	method position()
		= titanic.position().up(1)	
	
	method image() = image
		
	method estaVivo(){
		return vida > 0
	}
	
	method morite()
	{
		vida = 0
		image = "dead.gif"
	}
	
	
}


object iceberg{
	var distancia = 2
	
	method image() {return "iceberg.jpeg"}
	method position() {
		return 
		titanic.position().right(distancia)
	}
	
	method acercarse(){
		distancia = distancia - 1
	}
	
	method chocar(loQueFlota){
		loQueFlota.hundite()
	}
}

object puerta {
	var ocupante = jack
	var position = game.at(2,5)

	method position() { return position }
	method image() = ocupante.image()
	
	method salva() {
		ocupante.sobrevivi()
	}
	method ocupante() { return ocupante }
	
	method serOcupadaPor(alguien){
		ocupante = alguien
	}
	
	method hundite(){
		game.say(puerta, ocupante.pedirSocorro("Auxilio"))
	}
}

object jack {
	var dibujo
	method image() = "jack.png"
	
	method sobrevivi(){
		dibujo = "naufragio"
	}
	
	method pedirSocorro(mensaje){
		return mensaje + " Soy jack, y tengo frio!"
	}
}

object rose {
	var nombre = "rosa"

	method image() = "rose.jpeg"

	method sobrevivi(){
		nombre = "marina"
	}
	
	method comoTeLlamas(){
		return nombre
	}
	
	method pedirSocorro(mensaje){
		return mensaje + " soy " + nombre
	}
	
}