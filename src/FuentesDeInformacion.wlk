import Personalidades.*
import Relaciones.*
import Trabajos.*
import EstadosDeAnimo.*
import Celos.*
import Sim.*

class Libro{
	var titulo
	var capitulos = []
	
	constructor(unTitulo, unosCapitulos){
		titulo = unTitulo
		capitulos = unosCapitulos
	}
	
	method escribirCapitulo(nuevoCapitulo){
		capitulos.add(nuevoCapitulo)
	}
	
	method brindarInformacion(){
		return capitulos.anyOne()
	}
}

object tinelli inherits Sim("masculino", 45, 1000, [], interesado, 999999, "femenino")
{
	override method brindarInformacion(){
		return "Totó"
	}
}

object rial inherits Sim("masculino", 45, 1000, [], interesado, 888888, "femenino")
{
	override method brindarInformacion(){
		return "Escándalo"
	}
}