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
		unSim.personalidad().trabajar(unSim)
		unSim.volverALaNormalidad()
	}
	
}

class Copado inherits Trabajo {
	
	constructor (unSueldo, unaFelicidad) = super(unSueldo, unaFelicidad)
}

class Mercenario inherits Trabajo{
	
	constructor() = super(0, 0)
	
	method bonoMercenario(unSim){
		return unSim.dinero() * 0.02
	}
	
	override method trabajar(unSim){
		sueldo = 100 + self.bonoMercenario(unSim)
		super(unSim)
	}
}

class Aburrido inherits Trabajo{
	
	constructor (unSueldo, unaFelicidad) = super(unSueldo, unaFelicidad*(-1))

}

class AburridoHastaLaMuerte inherits Aburrido{
	var factorTristeza = 4 //Numero constante
	
	constructor(unSueldo,unaFelicidad) = super(unSueldo,unaFelicidad)
	
	override method trabajar(unSim){
		unSim.darFelicidad(felicidad * factorTristeza)
		unSim.darDinero(sueldo)
		unSim.personalidad().trabajar(self)
		unSim.volverALaNormalidad()		
	}
	
	
}

class MercenarioSocial inherits Mercenario{
	
	constructor() = super()

	override method trabajar(unSim){
		super(unSim)
		unSim.darDinero(unSim.cantidadDeAmigos())
	}
}

object desocupado inherits Trabajo (0,0){
	
	override method trabajar(unSim){
	}
}