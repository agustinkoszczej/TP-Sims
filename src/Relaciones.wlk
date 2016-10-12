import Sim.*

class Relacion{
	var unSim
	var otroSim
	var circuloDeAmigos = #{}
	var enCurso = true
	
	constructor(sim1, sim2){
		
		if(sim1.soltero() && sim2.soltero() && not sim1.menor() && not sim2.menor()){	
			unSim = sim1
			otroSim= sim2
			circuloDeAmigos = (unSim.amigos() + otroSim.amigos()).asSet()
			circuloDeAmigos.remove(unSim)
			circuloDeAmigos.remove(otroSim)
		}
		else{
			if(sim1.menor() || sim2.menor()){
				error.throwWithMessage("Dos sims no pueden iniciar una relacion si alguno de los dos tiene 16 anios o menos")
			}
			else{
				error.throwWithMessage("Un sim no puede iniciar una relacion si ya se encuentra en una")
			}
		}
	}
	
	
	method unSim(){
		return unSim
	}
	method otroSim(){
		return otroSim
	}
	method circuloDeAmigos(){
		return circuloDeAmigos
	}
	method enCurso (){
		return enCurso
	}
	
	method esMiembro(sim){
		return not sim.soltero() && (unSim === sim || otroSim === sim)
	}
	
	method terminar(){
		unSim.terminarRelacion()
		otroSim.terminarRelacion()
		enCurso = false
	}
	
	method funciona()
	{
		return(unSim.leAtrae(otroSim) && otroSim.leAtrae(unSim))
	}
	
	method sePudrioTodo(){
		var amigosGustados = circuloDeAmigos.filter({amigo => unSim.leAtrae(amigo) || otroSim.leAtrae(amigo)})
		return not self.funciona() && not amigosGustados.isEmpty()
	} 
	
	method reestablecer(){
		unSim.terminarRelacion()
		otroSim.terminarRelacion()
		enCurso = true
		unSim.empezarRelacionCon(otroSim)
	}
}


