class Actor{
    constructor(x,y,spd,dir,sight,life,type){
        this.p=createVector(x,y);
        this.spd=spd;
        this.dir=dir;
        this.sight=sight;
        this.life=life;
        this.sec=0;
        this.type=type;
        this.active=false;
    }
    update(){
        let v=createVector(this.spd*cos(this.dir),
                           this.spd*sin(this.dir));
        this.p.add(v);
        this.p.x=(this.p.x+width)%width;
        this.p.y=(this.p.y+height)%height;
        this.sec++;
    }
    draw(){
        stroke(0,255,0);
        strokeWeight(3);
        point(this.p.x,this.p.y);
        stroke(255,255,255,64);
        strokeWeight(1);
        ellipse(this.p.x,this.p.y,this.sight,this.sight);
    }
    survive(m){
        let a=[];
        m.points(createVector(this.p.x,this.p.y),this.sight,a);
        for(let i=0; i<a.length; i++)
            this.dir=int(a[i].type-this.type)*(a[i].dir-this.dir);
    }
}
