let qtree;
function setup(){
    colorMode(HSB,255);
    createCanvas(300,300);
    qtree=new QTree(0,0,width,height,4);
    for(let i=0; i<4; i++){
        let a=new Actor(random(width),random(height),
                        random(10)/5,random(360),
                        random(20)+20,5000,floor(random(2)));
        qtree.insert(a);
    }
}
function draw(){
    background(0);
    qtree.draw();
    qtree.map(a=>Actor.survive(a,qtree));
    qtree.map(a=>Actor.update(a));
    qtree.remove(a=>a.life<=a.tick);
    qtree.map(a=>Actor.draw(a));
}
