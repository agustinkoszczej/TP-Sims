import Sim.*

class Relacion{
	var unSim
	var otroSim
	var enCurso = true
	
	constructor(sim1, sim2){
		
		if(sim1.soltero() && sim2.soltero() && not sim1.menor() && not sim2.menor()){	
			unSim = sim1
			otroSim= sim2
		}
		else{
			if(sim1.menor() || sim2.menor()){
				self.error("Dos sims no pueden iniciar una relacion si alguno de los dos tiene 16 anios o menos")
			}
			else{
				self.error("Un sim no puede iniciar una relacion si ya se encuentra en una")
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
		return ((unSim.amigos() + otroSim.amigos()).asSet()).filter({amigo => not((amigo === unSim) || (amigo === otroSim))})
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
		return not self.funciona() && self.circuloDeAmigos().any({amigo => (unSim.leAtrae(amigo) || otroSim.leAtrae(amigo))})
	} 
	
	method reestablecer(){
		unSim.terminarRelacion()
		otroSim.terminarRelacion()
		enCurso = true
		unSim.empezarRelacionCon(otroSim)
	}
}


