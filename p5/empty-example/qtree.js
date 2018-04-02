class QTree{
    constructor(x,y,w,h,cap){
        this.cap=cap;
	this.x=x; this.y=y;
        this.w=w; this.h=h;
        this.ps=[];
        this.son=[null,null,null,null];
    }
    insert(p){
        if(!this.contains(p)) return;
        if(this.ps.length<this.cap){
	    this.ps.push(p);
	}else{
            for(let i=0; i<4; i++){
                if(!this.son[i]){
                    let sx=this.x+this.w/2*(i%2);
                    let sy=this.y+this.h/2*int(i/2);
                    this.son[i]=new QTree(sx,sy,this.w/2,this.h/2,this.cap);
                }            
                this.son[i].insert(p);
            }
        }
    }
    contains(p){
        return p.x>=this.x&&p.x<=this.x+this.w&&
            p.y>=this.y&&p.y<=this.y+this.h;
    }
    points(c,r,ps){
        if(c.x+r<this.x||c.x-r>this.x+this.w||
           c.y+r<this.y||c.y-r>this.y+this.h) return;
        for(let i=0; i<this.ps.length; i++)
            if(dist(c.x,c.y,this.ps[i].x,this.ps[i].y)<r) ps.push(this.ps[i]);
        for(let i=0; i<4; i++)
            if(this.son[i]) this.son[i].points(c,r,ps);
    }
    remove(f){
	for(let i=this.ps.length-1; i>=0; i--)
	    if(f(this.ps[i])) this.ps.splice(i,1);
	for(let i=0; i<4; i++)
	    if(this.son[i]) this.son[i].remove(f);
    }
    map(f){
	for(let i=this.ps.length-1; i>=0; i--) f(this.ps[i])
	for(let i=0; i<4; i++) if(this.son[i]) this.son[i].map(f);
    }
    draw(){
        noFill();
        stroke(255);
        strokeWeight(2);
        strokeWeight(5);
        for(let i=0; i<this.ps.length; i++)
            point(this.ps[i].x,this.ps[i].y);
        for(let i=0; i<4; i++)
            if(this.son[i]) this.son[i].draw();
    }
}
