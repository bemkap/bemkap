class QTree{
    constructor(x,y,w,h,cap){
        this.cap=cap;
        this.p=createVector(x,y);
        this.w=w; this.h=h;
        this.ps=[];
        this.son=[null,null,null,null];
    }
    insert(x,y){
        if(!this.contains(x,y)) return;
        if(this.ps.length<this.cap){
            this.ps.push(createVector(x,y));
        }else{
            for(let i=0; i<4; i++){
                if(!this.son[i]){
                    let sx=this.p.x+this.w/2*(i%2);
                    let sy=this.p.y+this.h/2*int(i/2);
                    this.son[i]=new QTree(sx,sy,this.w/2,this.h/2,this.cap);
                }            
                this.son[i].insert(x,y);
            }
        }
    }
    contains(x,y){
        return x>=this.p.x&&x<=this.p.x+this.w&&
            y>=this.p.y&&y<=this.p.y+this.h;
    }
    points(c,r,ps){
        if(c.x+r<this.p.x||c.x-r>this.p.x+this.w||
           c.y+r<this.p.y||c.y-r>this.p.y+this.h) return;
        for(let i=0; i<this.ps.length; i++)
            if(dist(c.x,c.y,this.ps[i].x,this.ps[i].y)<r)
                ps.push(this.ps[i]);
        for(let i=0; i<4; i++)
            if(this.son[i]) this.son[i].points(c,r,ps);
    }
    draw(){
        noFill();
        stroke(255);
        strokeWeight(2);
        rect(this.p.x,this.p.y,this.w,this.h);
        strokeWeight(5);
        for(let i=0; i<this.ps.length; i++)
            point(this.ps[i].x,this.ps[i].y);
        for(let i=0; i<4; i++)
            if(this.son[i]) this.son[i].draw();
    }
}
