class Actor extends p5.Vector{
    constructor(x,y,spd,dir,sight,life,type){
	super(x,y);
	this.spd=spd;
	this.v=createVector(spd*cos(dir),spd*sin(dir));
        this.sight=sight;
        this.life=life;
        this.tick=0;
        this.type=type;
    }
    static update(a){
        a.add(a.v);
        a.x=(a.x+width)%width;
        a.y=(a.y+height)%height;
	++a.tick;
    }
    static draw(a){
        stroke(255/2*a.type,255,255);
        strokeWeight(5);
        point(a.x,a.y);
        strokeWeight(1);
        ellipse(a.x,a.y,a.sight*2,a.sight*2);
    }
    static survive(a,m){
        let as=[];
        m.points(a,a.sight,as);
        for(let i=0; i<as.length; i++){
	    if(a!=as[i]&&a.tick>a.life/10){
		a.v=p5.Vector.sub(as[i],a);
		a.v.setMag(a.spd);
		if(as[i].type<a.type) a.v.mult(-1);
		if(p5.Vector.dist(as[i],a)<a.spd){
		    if(a.type==as[i].type){
			let n=new Actor(a.x,a.y,max(a.spd,as[i].spd),random(360),
					max(a.sight,as[i].sight),1000,a.type);
			m.insert(n);
		    }else if(a.type>as[i].type){
			a.tick=0;
			as[i].tick=as[i].life;
		    }
		}
	    }
	}
    }
}
