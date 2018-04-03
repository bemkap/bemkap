class Actor extends p5.Vector{
    constructor({x=null,y=null,spd=null,dir=null,sight=0,life=5000,type=null}){
	super(x?x:random(width),y?y:random(height));
	this.spd=spd?spd:random(1);
        dir=dir?dir:random(360);
	this.v=createVector(this.spd*cos(dir),this.spd*sin(dir));
        this.sight=random(20)+20;
        this.life=life;
        this.tick=0;
        this.type=type?type:floor(random(2));
        this.breed=2;
    }
    static update(a){
        a.add(a.v);
        if(a.x<0||a.x>width) a.v.x*=-1;
        if(a.y<0||a.y>height) a.v.y*=-1;
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
        let b=m.closest(a,a.sight);
        if(b){
	    a.v=p5.Vector.sub(b,a);
	    a.v.setMag(a.spd);
	    if(b.type>a.type) a.v.mult(-1);
	    if(p5.Vector.dist(b,a)<max(a.spd,b.spd)){
	        if(a.type==b.type){
                    let n=new Actor({spd:max(a.spd,b.spd),
                                     sight:max(a.sight,b.sight),
                                     type:a.type});
                    m.insert(n);
                    a.x=random(width); a.y=random(height);
                    b.x=random(width); b.y=random(height);
                    a.breed+=round(random(-1,1));
                    b.breed+=round(random(-1,1));
	        }else if(a.type>b.type){
		    a.tick=0;
		    b.tick=b.life;
	        }
	    }
        }
    }
}
