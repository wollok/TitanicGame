import wollok.game.*


object pelicula {
	
	method iniciar() {
		game.title("Titanic Game")
		game.height(12)
		game.width(12)
		game.ground("blue.jpg")
		game.addVisual(mar)	
		game.addVisual(titanic)
		game.start()
			
	}
		
	method momentoFeliz() {
		//game.addVisual(viento)
		game.addVisual(momentoFeliz)
	}
	
	method peligro(){
		if(game.hasVisual(momentoFeliz)) game.removeVisual(momentoFeliz)
	
		game.addVisual(iceberg)
		game.onCollideDo(iceberg, {obstaculo=>obstaculo.chocar()})
	}
	
	method pedidoAuxilio(){
		tabla.seSube(rose)
		tabla.pedirAyuda()
	}
	
	method rescate(){
		game.addVisual(barcoRescate)
		game.onCollideDo(barcoRescate, {victima => victima.salvar()})
	}
	
	method versionOriginal() {
		self.momentoFeliz()
		viento.soplar()
		game.schedule(1000,{viento.detener()})
		game.schedule(2000,{self.peligro()})
		game.schedule(3000,{
			8.times{x => 
				game.schedule(x*200,{iceberg.avanzar()})
			}
		})
		game.schedule(6000,{self.pedidoAuxilio()})
		game.schedule(7000,{self.rescate()})
		game.schedule(8000,{
			4.times{x=> 
				game.schedule(x*200,{barcoRescate.avanzar()})
			}
		})
		game.schedule(10000,{game.say(tabla,"Ahora soy " + rose.comoTeLlamas())})
		
		
		
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
		game.addVisual(tabla)
	}
	
	method sacudir() {
		position = position.up(1)
		game.schedule(100,{position = position.down(2)})
		game.schedule(200,{position = position.up(1)})
		
	}
	method salvar(){
		hundido = not hundido
	}
}	

object barcoRescate {
	
	var position = game.at(1,3)
	const image = "rescate.png"
	
	method image() { return image }
	method position() {return position}
	

	method avanzar() {
		position = position.right(1)
	}
	
	method chocar(){}
	
	
	
}

object mar {
	method position() = game.origin()
	method image() = "mar.jpg"
	
	method tormenta() {titanic.sacudir()}
}

object iceberg{
	var position = game.at(0,3)
	
	method image() {return "iceberg.png"}
	method position() {
		return position
	}
	
	method avanzar(){
		position = position.right(1)
	}
	method retroceder(){
		position = position.left(2)
	}
	
	method alcanzaA(elemento){
		position = elemento.position()
	}
	method salvar() {}

}

object tabla {
	var ocupante = nadie
	var property position = titanic.position().left(3)
	method image() = ocupante.image()
	
	method salvar() {
		ocupante.sobrevivir()
		position = position.up(1)
	}
	method ocupante() { return ocupante }
	
	method seSube(alguien){
		ocupante = alguien
	}
	method chocar() {
		self.pedirAyuda()
	}

	method pedirAyuda(){
		game.say(self, ocupante.pedirAyuda("Auxilio"))
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
    var property position  = game.at(4,7)
	method siguiente() {
		nro = (nro + 1)%10 + 1
	}
	method image() = "titanic-" + nro.toString() + ".gif"
	

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

