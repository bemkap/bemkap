class System{
    constructor(){
	this.actors=[];
    }
    push(a){
	this.actors.push(a);
    }
    map(f){
	this.actors.map(f);
    }
    remove(f){
	this.actors=this.actors.filter(a=>!f(a));
    }
    length(){
	return this.actors.length;
    }
    draw(){
	this.actors.map(a=>a.draw());
    }
    pairwise(f){
	for(let i=0; i<this.actors.length; i++)
	    for(let j=i+1; j<this.actors.length; j++)
		f(this.actors[i],this.actors[j]);
    }
}
