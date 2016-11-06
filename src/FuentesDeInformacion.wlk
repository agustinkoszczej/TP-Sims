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

object tinelli
{
	method brindarInformacion(){
		return "Totó"
	}
}

object rial
{
	method brindarInformacion(){
		return "Escándalo"
	}
}