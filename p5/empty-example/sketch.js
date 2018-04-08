let sys;
function setup(){
    colorMode(HSB,255);
    createCanvas(500,500);
    sys=new System();
    for(let i=0; i<10; i++) sys.push(new Actor({}));
}
function draw(){
    background(0);
    sys.pairwise((a,b)=>Actor.move(a,b));
    sys.map(a=>Actor.update(a));
    sys.pairwise((a,b)=>Actor.bok(a,b,sys));
    sys.remove(a=>a.life<a.tick);
    sys.map(a=>Actor.draw(a));
}
