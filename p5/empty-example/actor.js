class Actor extends p5.Vector{
    constructor({x=null,y=null,spd=null,dir=null,sight=0,life=5000,type=null,breed=2}){
	super(x?x:random(width),y?y:random(height));
	this.spd=spd?spd:random(1);
        dir=dir?dir:random(360);
	this.v=createVector(this.spd*cos(dir),this.spd*sin(dir));
        this.sight=random(20)+20;
        this.life=life;
        this.tick=0;
        this.type=type?type:floor(random(3));
	this.breed=breed;
    }
    static update(a){
        a.add(a.v);
        if(a.x<0||a.x>width) a.v.x*=-1;
        if(a.y<0||a.y>height) a.v.y*=-1;
	++a.tick;
    }
    static draw(a){
	noFill();
        stroke(255/3*a.type,255,255);
        strokeWeight(5);
        point(a.x,a.y);
        strokeWeight(1);
        ellipse(a.x,a.y,a.sight*2,a.sight*2);
    }
    static move(a,b){
	if(p5.Vector.dist(a,b)<a.sight){
	    a.v=p5.Vector.sub(b,a);
	    a.v.setMag(a.spd);
	    if(b.type>a.type) a.v.mult(-1);
	}
	if(p5.Vector.dist(a,b)<b.sight)
	    b.v=p5.Vector.mult(a.v,-1);
    }
    static bok(a,b,s){ // breed or kill
	if(p5.Vector.dist(a,b)<max(a.spd,b.spd))
	    if(a.type==b.type){
		for(let k=0; k<min(a.breed,b.breed); k++)
		    s.push(new Actor({spd:max(a.spd,b.spd),sight:max(a.sight,b.sight),
				      type:a.type,breed:max(a.breed,b.breed)}));
		a.x=random(width); a.y=random(height);
		b.x=random(width); b.y=random(height);
		a.breed+=round(random(-1,1));
		b.breed+=round(random(-1,1));
	    }else{
		a.tick=a.type==(b.type+1)%3?0:a.life;
		b.tick=b.type==(a.type+1)%3?0:b.life;
	    }
    }
}
