import Sim.*

class Relacion{
	var unSim
	var otroSim
	var enCurso = true
	
	constructor(sim1, sim2){
		
		if(self.puedenIniciarRelacion(sim1,sim2)){	
			unSim = sim1
			otroSim= sim2
		}
	}
	method mismo(){
		return self
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
	
	method puedenIniciarRelacion(sim1, sim2)
	{
		if(self.algunoEsMenor(sim1, sim2)){
				self.error("Dos sims no pueden iniciar una relacion si alguno de los dos tiene 16 anios o menos")
		}
		if(not self.ambosEstanSolteros(sim1,sim2)){
			self.error("Un sim no puede iniciar una relacion si ya se encuentra en una")
		}
		return true
	}
	
	method algunoEsMenor(sim1, sim2){
		return sim1.menor() || sim2.menor()	
	}
	
	method ambosEstanSolteros(sim1, sim2){
		return sim1.soltero() && sim2.soltero()
	}

}

object soltero inherits Relacion(null, null){
	
	override method mismo(){
		self.error("Este sim no tiene ninguna relacion")
		return self	
	}
	
	override method unSim(){
		
		self.error("Este sim no tiene pareja [soltero.unSim()]")		
		return 0
	}
	override method otroSim(){
		self.error("Este sim no tiene pareja [soltero.otroSim()]")	
		return 0
	}
	override method circuloDeAmigos(){
		self.error("Esta Relacion no existe [soltero.circuloDeAmigos()]")	
		return 0
	}
	override method enCurso (){
		return false
	}
	
	override method esMiembro(sim){
		self.error("Esta Relacion no existe [soltero.esMiembro(sim)]")	
		return 0
	}
	
	override method terminar(){
		self.error("No se puede terminar la relacion soltero")	
	}
	
	override method funciona()
	{
		self.error("Este sim esta soltero [soltero.funciona()]")
		return false
	}
	
	override method sePudrioTodo(){
		self.error("Este sim esta soltero [soltero.sePudrioTodo()]")
		return false
	}
	
	override method reestablecer(){
		self.error("No se puede reestablecer la relacion soltero")	
	}
	
	override method puedenIniciarRelacion(sim1, sim2)
	{
		return true
	}
}