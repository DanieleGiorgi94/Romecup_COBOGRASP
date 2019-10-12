float speed = 0.003; // regola la velocità di chiusura delle dita  

//coordinate (x,y,z) dell'oggetto da afferrare 
float xObj = 100; //x centro oggetto
float yObj = 0; //y centro oggetto
float zObj = 0; //z centro oggetto
float xmObj = 500; //x centro oggetto
float ymObj = 500; //y centro oggetto
float zmObj = 0; //z centro oggetto
float rObj = 120; //raggio oggetto(sfera)
float xHand = 0;
float yHand = 0;
float zHand = 0;

float eyeR = 1300; // distanza della camera

float spazio = 30; // spazio tra le dita
float spessore = 40; // spessore della mano

// variabili di distanza {indice, medio, anulare, mignolo, pollice, palmo}
float w[] = {0,0,0,0,0,0,0}; // utile per calcolare la distanza
float distance[] = {0,0,0,0,0,0,0}; // distanze misurate
float precision = 1; // precisione della misura (in pixel)
int MAXDIST = 500; // massima distanza misurabile (in pixel)
// coordinate w rispetto al model {indice, medio, anulare, mignolo, pollice, palmo} {x,y,z}
float[][] qDist= {{0,0,0},{0,0,0},{0,0,0},{0,0,0},{0,0,0},{0,0,0},{0,0,0}};

// dimensioni link dita {indice, medio, anulare, mignolo, pollice} {falange,falangina,falangetta}
float lx[][] = {{10,10,10}, {10,10,10}, {10,10,10}, {10,10,10},{10,10,10}};
float ly[][] = {{130,100,60}, {150,110,70}, {150,110,70}, {120,90,50},{160,70,50}};
float lz[][] = {{40,40,40}, {40,40,40}, {40,40,40}, {40,40,40},{40,40,40}};

// angoli {indice, medio, anulare, mignolo}
float[][] theta = {{PI,0,0},{PI,0,0},{PI,0,0},{PI,0,0}};
float[][] THMIN = {{PI,0,0},{PI,0,0},{PI,0,0},{PI,0,0}};
float[][] THMAX = {{3*PI/2,5*PI/9,4*PI/9},{3*PI/2,5*PI/9,4*PI/9},{3*PI/2,5*PI/9,4*PI/9},{3*PI/2,5*PI/9,4*PI/9}};
float[][] fingerVel = {{0,0,0},{0,0,0},{0,0,0},{0,0,0}}; // velocità chiusura giunti dita {indice, medio, anulare, mignolo}
//float[][] fingerVel = {{PI*speed,PI*speed,PI*speed},{PI*speed,PI*speed,PI*speed},{PI*speed,PI*speed,PI*speed},{PI*speed,PI*speed,PI*speed}};

// angoli giunti pollice
float[] thumb = {PI/4,-PI/9,PI/9,0}; 
float[] THBMIN = {0,-PI/9,PI/9,0};
float[] THBMAX = {PI/3,-PI/10,PI/4,PI/3};
float[] thumbVel = {speed,speed,speed,speed}; // velocità chiusura giunti pollice 

float wristR = 0;
float wristH = 50;
float lpalmo = 0;
float lbraccio = 400; // lunghezza avambraccio

/*                controllo equilibrio:
  omegaDes = k_omega * (thetaDes - theta)
  alpha(k) = k_alpha * (omegaDes - omega)
  omega(k) = omega(k-1) + alpha(k) * k
  thetaC(k) = thetaC(k-1) + omega(k-1) * k + alpha * k^2 / 2

  se |alpha(k)| > 0.3 * omegaPM, allora alpha(k) = 0.3 * omegaPM se k > 0
                                        alpha(k) = - 0.3 * omegaPM altrimenti
*/
//variabili per controllo dell'equilibrio
int balance = 0; //var. attivazione controllo equilibrio
float thetaDes = PI/2;
float omegaDes;
float alpha;
float omegaDesR;
float alphaR;
float k_alpha = 0.8;
float k_omega = 0.7;
float dt = (float) 1/60;
float omegaPM = 10;
float omega = 0;
float omegaR = 0;

float g = 9.8; //acc. gravità
//variabili lettura accelerometro esatti
float Ax = 0;
float Ay = 0;
float Az = g;

//variabili lettura accelerometro reali e filtrate
float Axr = 0;
float Ayr = 0;
float Azr = 0;

//letture accelerometro perturbate
float Axl;
float Ayl;
float Azl;

//deviazione standard perturbazioni
float stDev = 0.001;

float V;
float arg;
//angoli psi e theta esatti
float lean = 0;
float wrist = 0;
float plan = 0; // angolo phi
//angoli psi e theta stimati
float leanHat = 0;
float wristHat = 0;
//costante filtro passa-basso
float a_fil = 0.8;

float tempoUltimaMisura;

int close = 0; // se attivo chiude la mano
int open = 0; // se attivo apre la mano

boolean blocked = false; // dice se la palla è bloccata alla mano

float R[][] = {{ -sin(wrist)*sin(plan + PI/2),   cos(lean)*cos(wrist) - sin(lean)*cos(plan + PI/2)*sin(wrist), cos(wrist)*sin(lean) + cos(lean)*cos(plan + PI/2)*sin(wrist)},
{            -cos(plan + PI/2),                                     sin(lean)*sin(plan + PI/2),                                  -cos(lean)*sin(plan + PI/2)},
{ -cos(wrist)*sin(plan + PI/2), - cos(lean)*sin(wrist) - cos(wrist)*sin(lean)*cos(plan + PI/2), cos(lean)*cos(wrist)*cos(plan + PI/2) - sin(lean)*sin(wrist)}};
 
/*float R[][] = {{-sin(wrist)*sin(plan + PI/2),cos(plan + PI/2),-cos(wrist)*sin(plan + PI/2)},
{ sin(lean)*cos(plan + PI/2)*sin(wrist) - cos(lean)*cos(wrist), sin(lean)*sin(plan + PI/2), cos(lean)*sin(wrist) + cos(wrist)*sin(lean)*cos(plan + PI/2)},
{ cos(wrist)*sin(lean) + cos(lean)*cos(plan + PI/2)*sin(wrist), cos(lean)*sin(plan + PI/2), cos(lean)*cos(wrist)*cos(plan + PI/2) - sin(lean)*sin(wrist)}};*/
//float R[][] = {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}};

import g4p_controls.*;  
import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

ControlIO control;
Configuration config;
ControlDevice gpad;

float handx;
float handy = PI/3;
float objx = 500;
float objy = 500;
float objz = 0;

boolean up;
boolean down;
boolean grasp;
boolean release;
boolean hit;
boolean sw;

boolean pressed = false;