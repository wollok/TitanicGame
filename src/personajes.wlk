import wollok.game.*


// Este objeto esta para cargar mas facil la config en la consola
object pelicula
{
	method inicio()
	{
		game.title("TitanicGame")
		game.height(14)
		game.width(12)
		game.ground("blue.jpg")

        game.addVisual(mar)	
		game.addVisual(titanic)
//		game.addVisual(iceberg)
		game.addVisual(viento)
		game.addVisual(barcoRescate)
		game.onCollideDo(barcoRescate, {victima => victima.salvar()})
			
		game.start()
	}
}


object titanic{
	
	var position = game.at(8,3)
	var hundido = false
	
	method image() {
		return "titanic" + (if(hundido) "hundido" else "navegando") + ".png"
    }

	method position() { return position}
	
	method puedeFlotar() {
		return !hundido
	}
	
	method chocar(){
		hundido = true
		puerta.aparecer()
	}
	method tormenta() {
		position = position.up(1)
		game.schedule(200,{position = position.down(1)})
	}
	method salvar(){
		hundido = not hundido
	}
	method momentoFeliz(){
		animacion.aparecer()
	}

}	

object barcoRescate {
	
	var position = game.at(0,3)
	const image = "rescate.png"
	
	method image() { return image }
	method position() {return position}
	
	method aparecer(){
		game.addVisual(barcoRescate)
		game.onCollideDo(barcoRescate, {victima => victima.salvar()})
	}
	method moverse() {
		position = position.right(1)
	}
	
	
	
}

object mar {
	method position() = game.origin()
	method image() = "mar.jpg"
}

object iceberg{
	var position = game.at(11,3)
	
	method image() {return "iceberg.jpeg"}
	method position() {
		return position
	}
	
	method moverse(){
		position = position.left(1)
	}
	method aparecer(){
		game.addVisual(iceberg)
		game.onCollideDo(iceberg, {obstaculo=>obstaculo.chocar()})
		
	}
	
	method alcanzaA(elemento){
		position = elemento.position()
	}
	method salvar() {}

}

object puerta {
	var ocupante = nadie

	method position() { return titanic.position().left(3) }
	method image() = ocupante.image()
	
	method salvar() {
		ocupante.sobrevivir()
	}
	method ocupante() { return ocupante }
	
	method seSube(alguien){
		ocupante = alguien
	}
	method chocar() {
		puerta.pedirAyuda()
	}

	method pedirAyuda(){
		game.say(puerta, ocupante.pedirAyuda("Auxilio"))
	}
	
	method aparecer(){
		game.addVisual(puerta)
	}
	
}

object jack {
	var image = "jack.png"
	
	method image() {return image}
	
	method sobrevivir(){
		image = "dicaprio.jpg"
	}
	
	
	method pedirAyuda(mensaje){
		return mensaje + " Soy jack, y tengo frio!"
	}
}

object nadie {
	
	method image() = "puerta.jpg"
}

object rose {
	var nombre = "Rosa Bukater"

	method image() = "rose.png"

	method sobrevivir(){
		nombre = "Sra Dawson"
	}
	
	method comoTeLlamas(){
		return nombre
	}
	
	method pedirAyuda(mensaje){
		return mensaje + " soy " + nombre
	}
	
}


object animacion {
	var nro  = 1
    var property position  = game.at(3,10)
	method siguiente() {
		nro = (nro + 1)%10 + 1
	}
	method image() = "titanic-" + nro + ".gif"
	
	method aparecer() {
		game.addVisual(animacion)
	}

}

object viento {
	var property image = "blue.jpg"
	var property position = game.at(3,3)
	method soplar() {
		game.onTick(40,"viento",{animacion.siguiente()})
	}
	method detener() {
		game.removeTickEvent("viento")
	}
	method chocar(){}
	method salvar(){}

}

