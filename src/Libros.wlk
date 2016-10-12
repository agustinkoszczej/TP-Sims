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
	
	method escribirCapitulo(nvoCapitulo){
		capitulos.add(nvoCapitulo)
	}
	
	method brindarInformacion(){
		return capitulos.anyOne()
	}
}