/** First Wollok example */
object puerta {
	var ocupante
	method salva() {
		ocupante.sobrevivi()
	}
	method serOcupadaPor(alguien){
		ocupante = alguien
	}
}

object jack {
	var dibujo
	method sobrevivi(){
		dibujo = "naufragio"
	}
}

object rose {
	var nombre = "rosa"
	method sobrevivi(){
		nombre = "marina"
	}
	method comoTeLlamas(){
	return nombre
	}
}