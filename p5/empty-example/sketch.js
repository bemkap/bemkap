let qtree;
let actors;
function setup(){
    createCanvas(300,300);
    qtree=new QTree(0,0,width,height,4);    
    actors=[];
    for(let i=0; i<10; i++){
        let a=new Actor(random(width),random(height),
                        random(5)/10,random(360),
                        random(20)+20,100,random(3));
        actors.push(a);
        qtree.insert(a);
    }
    
}
function draw(){
    background(0);
    qtree.draw();
    for(let i=0; i<10; i++) actors[i].survive(qtree);
    for(let i=0; i<10; i++) actors[i].update();
    for(let i=0; i<10; i++) actors[i].draw();
}
