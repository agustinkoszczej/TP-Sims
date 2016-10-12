import Personalidades.*
import Relaciones.*
import Trabajos.*
import EstadosDeAnimo.*
import Celos.*
import Sim.*

class Vim inherits Sim {	
	constructor(unSexo,unNivelDeFelicidad,unosAmigos,unaPersonalidad,unDinero,unaPreferencia) = super(unSexo,18,unNivelDeFelicidad,unosAmigos,unaPersonalidad,unDinero,unaPreferencia)
	
	override method edad(nvaEdad){
		error.throwWithMessage("Los Vims tienen siempre 18 anios")
	}
}