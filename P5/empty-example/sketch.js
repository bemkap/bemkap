function Object(x,y,sp,dir){
    this.speed=sp; this.direction=dir; this.x=x; this.y=y;
    this.hspeed=this.vspeed=0;
    this.update=function(){
	this.x+=this.hspeed; this.y+=this.vspeed;
	this.x+=cos(radians(this.direction))*this.speed;
	this.y+=sin(radians(this.direction))*this.speed;
    }
    this.inside=function(){return this.x>0&&this.x<300&&this.y>0&&this.y<300;}
    this.draw=function(){
	fill(255,0,0);
	ellipse(this.x,this.y,4);
    }
}
var o=[],running=true,ddirection=8,button,l;
function setup() {
    createCanvas(300,300);
    o.push(new Object(100,100,5,45));
    // o.push(new object(100,100,5,45));
    // o.push(new object(100,100,5,45));
    l=o.length;
    for(var i=0; i<o.length; i++) o[i].hspeed=1;
    button=createButton();
    button.mouseClicked(toggle);
}
function toggle(){running=!running;}
function draw() {
    background(128);
    if(running){
    	for(var i=0; i<l; i++){
    	    o[i].direction=(o[i].direction+ddirection+i)%360;
    	    for(var j=0; j<4; j++){
    		o.push(new Object(o[i].x,o[i].y,1+j*0.5,o[i].direction));
    	    }
    	}
    	for(var i=o.length-1; i>=0; i--){
    	    o[i].update();
    	    if(!o[i].inside()){o.splice(i,1);}
    	    else{o[i].draw();}
    	}
    }else{
    	for(var i=o.length-1; i>=0; i--){
    	    o[i].draw();
    	}
    }
}
