import wollok.game.*


object pelicula {
	
	method iniciar() {
		game.title("TitanicGame")
		game.height(14)
		game.width(12)
		game.ground("blue.jpg")

        game.addVisual(mar)	
		game.addVisual(titanic)
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
	method sacudir() {
		position = position.up(1)
		game.schedule(200,{position = position.down(1)})
	}
	method salvar(){
		hundido = not hundido
	}
	method vivirMomentoFeliz(){
		momentoFeliz.aparecer()
	}

}	

object barcoRescate {
	
	var position = game.at(-1,3)
	const image = "rescate.png"
	
	method image() { return image }
	method position() {return position}
	

	method moverse() {
		position = position.right(1)
	}
	
	method retroceder(){
		position = position.left(2)
	}
	method chocar(){}
	
	
	
}

object mar {
	method position() = game.origin()
	method image() = "mar.jpg"
	
	method tormenta() {titanic.sacudir()}
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
	method retroceder(){
		position = position.right(2)
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
		image = "jackMayor.jpg"
	}
	
	
	method pedirAyuda(mensaje){
		return mensaje + " Soy jack, y tengo frio!"
	}
}

object nadie {
	
	method image() = "puerta.png"
	method pedirAyuda(mensaje) {return "Ya no hay nadie"}
	method sobrevivir(){}
}

object rose {
	var nombre = "Rosa Bukater"
	var image = "rose.png"
	
	method image() {return image}

	method sobrevivir(){
		nombre = "Sra Dawson"
		image = "roseMayor.jpg"
	}
	
	method comoTeLlamas(){
		return nombre
	}
	
	method pedirAyuda(mensaje){
		return mensaje + " soy " + nombre
	}
	
}


object momentoFeliz{
	var nro  = 1
    var property position  = game.at(4,9)
	method siguiente() {
		nro = (nro + 1)%10 + 1
	}
	method image() = "titanic-" + nro + ".gif"
	
	method aparecer() {
		game.addVisual(momentoFeliz)
	}

}

object viento {
	var property image = "blue.jpg"
	var property position = game.at(3,3)
	method soplar() {
		if(!game.hasVisual(momentoFeliz)) game.addVisual(momentoFeliz)
		game.onTick(40,"viento",{momentoFeliz.siguiente()})
	}
	method detener() {
		game.removeTickEvent("viento")
	}
	method chocar(){ 
		self.soplar()
	}
	method salvar(){
		
	}

}

