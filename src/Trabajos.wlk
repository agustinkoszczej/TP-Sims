import Sim.*

class Trabajo {
	var sueldo
	var felicidad
	
	constructor (unSueldo, unaFelicidad){
		sueldo = unSueldo
		felicidad = unaFelicidad
	}

	method trabajar(unSim){
		unSim.darFelicidad(self.felicidad(unSim))
		unSim.recibirDinero(self.sueldo(unSim))
		unSim.personalidad().trabajar(unSim)
		unSim.volverALaNormalidad()
	}
	
	method sueldo(unSim){
		return sueldo
	}
	
	method felicidad(unSim){
		return felicidad
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
	
	override method sueldo(unSim){
		return 100 + self.bonoMercenario(unSim)
	}
}

class Aburrido inherits Trabajo{
	
	constructor (unSueldo, unaFelicidad) = super(unSueldo, unaFelicidad*(-1))

}

class AburridoHastaLaMuerte inherits Aburrido{
	var factorTristeza = 4 //Numero constante
	
	constructor(unSueldo,unaFelicidad) = super(unSueldo,unaFelicidad)
	
	override method felicidad(unSim)
	{
		return felicidad * factorTristeza
	}
	
}

class MercenarioSocial inherits Mercenario{
	
	constructor() = super()

	override method trabajar(unSim){
		super(unSim)
		unSim.recibirDinero(unSim.cantidadDeAmigos())
	}
}

object desocupado inherits Trabajo (0,0){
	
	override method trabajar(unSim){
	}
}