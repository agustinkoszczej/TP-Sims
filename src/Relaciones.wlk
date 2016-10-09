import Sim.*

class Relacion{
	var unSim
	var otroSim
	var circuloDeAmigos = #{}
	var enCurso = true
	
	constructor(sim1, sim2){
		unSim = sim1
		otroSim= sim2
		circuloDeAmigos = (unSim.amigos() + otroSim.amigos()).asSet()
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
		return(unSim === sim || otroSim === sim)
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
		if(self.funciona()){ 
			return false
		}
		else{
			var amigosGustados = circuloDeAmigos.filter({amigo => (unSim.leAtrae(amigo) || otroSim.leAtrae(amigo)) && amigo != unSim && amigo != otroSim})
			return not amigosGustados.isEmpty()
		}
	}
	
	method reestablecer(){
		unSim.terminarRelacion()
		otroSim.terminarRelacion()
		enCurso = true
		unSim.empezarRelacionCon(otroSim)
	}
}
