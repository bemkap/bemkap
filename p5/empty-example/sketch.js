let qtree;
function setup(){
    colorMode(HSB,255);
    createCanvas(500,500);
    qtree=new QTree(0,0,width,height,4);
    for(let i=0; i<5; i++)
        qtree.insert(new Actor({}));
}
function draw(){
    background(0);
    qtree.draw();
    qtree.map(a=>Actor.survive(a,qtree));
    qtree.map(a=>Actor.update(a));
    qtree.remove(a=>a.life<a.tick);
    qtree.map(a=>Actor.draw(a));
}
