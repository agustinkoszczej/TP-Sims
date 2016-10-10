import Sim.*

class Trabajo {
	var sueldo
	var felicidad
	
	constructor (unSueldo, unaFelicidad){
		sueldo = unSueldo
		felicidad = unaFelicidad
	}
	
	method trabajar(unSim){
		unSim.darFelicidad(felicidad)
		unSim.darDinero(sueldo)
		unSim.personalidad().trabajar(self)
	}
}

class Copado inherits Trabajo {
	
	constructor (unSueldo, unaFelicidad) = super(unSueldo, unaFelicidad){
		sueldo = unSueldo
		felicidad = unaFelicidad
	}
}


class Mercenario inherits Trabajo{
	
	constructor (unSueldo, unaFelicidad) = super(unSueldo, unaFelicidad){
		sueldo = unSueldo
		felicidad = unaFelicidad
	}
	override method trabajar(unSim){
		unSim.darDinero(100 + 0.02 * unSim.dinero())
	}
}

class Aburrido inherits Trabajo{
	
	constructor (unSueldo, unaFelicidad) = super(unSueldo, unaFelicidad){
		sueldo = unSueldo
		felicidad = -unaFelicidad
	}	
}

object desocupado inherits Trabajo (0,0){ }