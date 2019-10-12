void disegno(){
  drawModelObj(); // disegno della palla, se non afferrata 
  translate(width/2, height/2);
  // posizionamento telecamera
  rotateZ(PI/2); 
  rotateX(PI/2);
  translate(height/4.0,0); 
  // fine posizionamento
  pushMatrix(); // sistema iniziale (centro della stanza), ruotato secondo la camera
  translate(0, lpalmo/2+(3*wristH/2)+lbraccio, 0); // traslazione per disegnare il polso
  rotateZ(lean); // ruota il gomito per alzare/abbassare la mano
  rotateX(plan+PI/2); // rotazione lungo il piano orizzontale
  fill(80,80,80);
  drawCaveCylinder(8,wristR,wristR-10,wristH); // bracciale fisso vicino al gomito
  translate(0,0,wristH);
  fill(150,150,150);
  rotateZ(wrist); // rotazione polso
  drawCaveCylinder(8,wristR,wristR-10,wristH); // bracciale mobile vicino al gomito
  pushMatrix(); 
  translate(0,wristR-10,lbraccio/2);
  drawCylinder(30,10,lbraccio-(wristH/2)); // primo collegamento bracciali distanti
  translate(0,20-wristR*2,0);
  drawCylinder(30,10,lbraccio-(wristH/2)); // secondo collegamento bracciali distanti
  popMatrix();
  translate(0,0,lbraccio-(wristH/2));
  drawCaveCylinder(8,wristR,wristR-10,wristH); // bracciale mobile vicino al polso
  translate(0,0,wrist/2);
  rotateX(-PI/2);
  translate(0,-(lpalmo+wristH)/2,0); // centro della mano ruotata, sistema di base 
  pushMatrix(); // push del sistema di base (centro della mano)
  translate(-wristR/sqrt(2),-lpalmo/2,-lpalmo/2+2*10); // sposto il palmo in modo che unisca due angoli del bracciale ottagonale
  drawHand(); 
  popMatrix(); // torno al sistema di base (centro della mano)
  drawBlockedObj(); // disegno della palla, se afferrata
  popMatrix(); // torno al sistema iniziale (centro della stanza) 
}

void drawHand(){
  pushMatrix(); // push del sistema del primo dito (mignolo)
  for (int g=3; g>=0; g--){
    pushMatrix(); 
    drawFinger(g);
    popMatrix();
    translate(0,0,lz[0][0]+spazio);
  }
  popMatrix(); // torno al sistema del primo dito (mignolo)
  
  translate(0,lpalmo/4,3*(lz[0][0]+spazio)/2); // palmo
  pushMatrix();
  box(lx[0][0],lpalmo/2,lpalmo);
  translate(0,lpalmo/4,0);
  rotateY(-PI/2);
  drawCylinder(30, lpalmo/2, lx[0][0]);
  
  translate(0,0,-spessore);
  translate(0,0,spessore+lx[0][0]);
  fill(150,150,150); //grigio
  rotateY(PI/2); 
  translate(wristR*sqrt(2)/3,lpalmo/2,7*lpalmo/16);
  rotateY(PI/2); // pollice
  drawThumb();
  popMatrix();
}

void drawThumb(){
  fill(255,255,255);
  rotateX(PI/2);
  drawCylinder(30,15,50); //indicazione precisa del centro
  fill(150,150,150);
  
  rotateZ(thumb[0]);
  //le seguenti rotazioni rendono più naturale il movimento del pollice
  rotateY(PI); 
  rotateX(-PI/3);
  rotateY((3*thumb[0]-PI)/4);
  drawCylinder(30,15,50);
  
  rotateZ(thumb[1]);
  pushMatrix();
  translate(0, ly[4][0]/2);
  box(lx[4][0], ly[4][0], lz[4][0]);
  translate(0, ly[4][0]/2);
  drawCylinder(30, lx[4][0]/2+2, lz[4][0]+4);
  popMatrix();
  
  translate(0, ly[4][0]);
  rotateZ(thumb[2]);
  pushMatrix();
  translate(0, ly[4][1]/2);
  box(lx[4][1], ly[4][1], lz[4][1]);
  translate(0, ly[4][1]/2);
  drawCylinder(30, lx[4][1]/2+2, lz[4][1]+2);
  popMatrix();
  
  translate(0, ly[4][1]);
  rotateZ(thumb[3]);
  pushMatrix();
  translate(0, ly[4][2]/2);
  box(lx[4][2], ly[4][2], lz[4][2]);
  drawRing(4,2);
  
  gotDistance(4); // per trovare la distanza pollice-palla
  
  translate(0,ly[4][2]/2,0); 
  rotateY(PI/2);
  drawCylinder(30,lz[4][2]/2,lx[4][2]);
  popMatrix();
}

void drawFinger(int g){
  fill(255,255,255);
  drawCylinder(30,15,50);
  fill(150,150,150);
  
  rotateZ(theta[g][0]);
  pushMatrix();
  translate(0, ly[g][0]/2);
  box(lx[g][0], ly[g][0], lz[g][0]);
  drawRing(g,0);
  translate(0, ly[g][0]/2);
  drawCylinder(30, lx[g][0]/2+2, lz[g][0]+4);
  popMatrix();
  
  translate(0, ly[g][0]);
  rotateZ(theta[g][1]);
  pushMatrix();
  translate(0, ly[g][1]/2);
  box(lx[g][1], ly[g][1], lz[g][1]);
  drawRing(g,1);
  translate(0, ly[g][1]/2);
  drawCylinder(30, lx[g][1]/2+2, lz[g][1]+2);
  popMatrix();
  
  translate(0, ly[g][1]);
  rotateZ(theta[g][2]);
  pushMatrix();
  translate(0, ly[g][2]/2);
  box(lx[g][2], ly[g][2], lz[g][2]);
  drawRing(g,2);
  
  gotDistance(g); // per trovare la distanza dito-palla
  
  translate(0,ly[g][2]/2,0); 
  rotateY(PI/2);
  drawCylinder(30,lz[g][2]/2,lx[g][2]);
  popMatrix();  
}

void drawRing(int g, int f){
    fill(50);
    pushMatrix();
    pushMatrix();
    translate(-spessore/2+lz[g][f]/8,0,-(lz[g][f]-lx[g][f])/2);
    box(spessore-lz[g][f]/2,ly[g][f]/2,lx[g][f]);
    translate(0,0,lz[g][f]-lx[g][f]);
    box(spessore-lz[g][f]/2,ly[g][f]/2,lx[g][f]);
    popMatrix();
    translate(-spessore+(lz[g][f]/2),0,0);
    rotateZ(PI/2);
    rotateY(PI/2);
    drawHalfCylinder(30,lz[g][f]/2,(lz[g][f]-lx[g][f])/2,ly[g][f]/2);
    fill(150);
    popMatrix(); 
}

void drawCylinder( int sides, float r, float h)
{
    float angle = 360 / sides;
    float halfHeight = h / 2;
    // draw top of the tube
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, -halfHeight);
    }
    endShape(CLOSE);
    // draw bottom of the tube
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, halfHeight);
    }
    endShape(CLOSE);
    // draw sides
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides + 1; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, halfHeight);
        vertex( x, y, -halfHeight);    
    }
    endShape(CLOSE);
}
void drawHalfCylinder( int sides, float r1, float r2, float h)
{
    float angle = 180 / sides;
    float halfHeight = h / 2;
    float x = cos( radians( sides * angle ) ) * r2;
    float y = sin( radians( sides * angle ) ) * r2;
    // draw top of the tube
    beginShape();
    for (int i = 0; i <= sides; i++) {
        float x1 = cos( radians( i * angle ) ) * r1;
        float y1 = sin( radians( i * angle ) ) * r1;
        vertex( x1,y1,-halfHeight);
    }
    vertex(x,y,-halfHeight);
    for (int i = sides - 1; i >= 0; i--) {
        float x2 = cos( radians( i * angle ) ) * r2;
        float y2 = sin( radians( i * angle ) ) * r2;
        vertex( x2,y2,-halfHeight);
    }
    vertex(r1,0,-halfHeight);
    endShape(CLOSE);
    // draw bottom of the tube
    beginShape();
    for (int i = 0; i <= sides; i++) {
        float x1 = cos( radians( i * angle ) ) * r1;
        float y1 = sin( radians( i * angle ) ) * r1;
        vertex( x1, y1, halfHeight);
    }
    vertex(x,y,halfHeight);
    for (int i = sides - 1; i >= 0; i--) {
        float x2 = cos( radians( i * angle ) ) * r2;
        float y2 = sin( radians( i * angle ) ) * r2;
        vertex( x2,y2,halfHeight);
    }
    vertex(r1,0,halfHeight);
    endShape(CLOSE);
    // draw sides
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i <= sides+1; i++) {
        float x1 = cos( radians( i * angle ) ) * r1;
        float y1 = sin( radians( i * angle ) ) * r1;
        vertex( x1, y1, halfHeight);
        vertex( x1, y1, -halfHeight);    
    }
    vertex(x,y,-halfHeight);
    for (int i = sides +1; i >= 0; i--) {
        float x2 = cos( radians( i * angle ) ) * r2;
        float y2 = sin( radians( i * angle ) ) * r2;
        vertex( x2, y2, halfHeight);
        vertex( x2, y2, -halfHeight);    
    }
    vertex(r1,0,halfHeight);
    endShape(); 
}

void drawCaveCylinder( int sides, float r1, float r2, float h)
{
    float angle = 360 / sides;
    float halfHeight = h / 2;
    float x = cos( radians( sides * angle ) ) * r2;
    float y = sin( radians( sides * angle ) ) * r2;
    // draw top of the tube
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x1 = cos( radians( i * angle ) ) * r1;
        float y1 = sin( radians( i * angle ) ) * r1;
        vertex( x1,y1,-halfHeight);
    }
    vertex(x,y,-halfHeight);
    for (int i = sides - 1; i >= 0; i--) {
        float x2 = cos( radians( i * angle ) ) * r2;
        float y2 = sin( radians( i * angle ) ) * r2;
        vertex( x2,y2,-halfHeight);
    }
    vertex(r1,0,-halfHeight);
    endShape(CLOSE);
    // draw bottom of the tube
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x1 = cos( radians( i * angle ) ) * r1;
        float y1 = sin( radians( i * angle ) ) * r1;
        vertex( x1, y1, halfHeight);
    }
    vertex(x,y,halfHeight);
    for (int i = sides - 1; i >= 0; i--) {
        float x2 = cos( radians( i * angle ) ) * r2;
        float y2 = sin( radians( i * angle ) ) * r2;
        vertex( x2,y2,halfHeight);
    }
    vertex(r1,0,halfHeight);
    endShape(CLOSE);
    // draw sides
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides+1; i++) {
        float x1 = cos( radians( i * angle ) ) * r1;
        float y1 = sin( radians( i * angle ) ) * r1;
        vertex( x1, y1, halfHeight);
        vertex( x1, y1, -halfHeight);    
    }
    vertex(x,y,-halfHeight);
    for (int i = sides ; i >= 0; i--) {
        float x2 = cos( radians( i * angle ) ) * r2;
        float y2 = sin( radians( i * angle ) ) * r2;
        vertex( x2, y2, halfHeight);
        vertex( x2, y2, -halfHeight);    
    }
    vertex(r1,0,halfHeight);
    endShape(); 
}

float[] findDistance(float l1, float l2, float l3, int index) { // cinematica diretta dito, può sempre essere utile
   float qDes[] = {0,0,0};
   qDes[0] = l1*cos(theta[index][0]) + l2*cos((theta[index][0]+theta[index][1])) + l3*cos((theta[index][0]+theta[index][1]+theta[index][2]));
   qDes[1] = l1*sin(theta[index][0]) + l2*sin((theta[index][0]+theta[index][1])) + l3*sin((theta[index][0]+theta[index][1]+theta[index][2]));
   qDes[2] = index*spazio + 2*index*lz[0][0]/2;
   return qDes;
}

void drawCone( int sides, float r1, float r2, float h)
{
    float angle = 360 / sides;
    float halfHeight = h / 2;

    // draw top of the tube
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r1;
        float y = sin( radians( i * angle ) ) * r1;
        vertex( x, y, -halfHeight);
    }
    endShape(CLOSE);

    // draw bottom of the tube
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r2;
        float y = sin( radians( i * angle ) ) * r2;
        vertex( x, y, halfHeight);
    }
    endShape(CLOSE);
    
    // draw sides
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides + 1; i++) {
        float x1 = cos( radians( i * angle ) ) * r1;
        float y1 = sin( radians( i * angle ) ) * r1;
        float x2 = cos( radians( i * angle ) ) * r2;
        float y2 = sin( radians( i * angle ) ) * r2;
        vertex( x1, y1, -halfHeight);
        vertex( x2, y2, halfHeight);    
    }
    endShape(CLOSE);

}