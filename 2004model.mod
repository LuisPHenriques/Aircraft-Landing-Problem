/*********************************************
 * OPL 22.1.0.0 Model
 * Author: luish
 * Creation Date: 29/12/2022 at 12:05:23
 *********************************************/

 // Parameters
int p= ... ;
range planes= 1..p;
 
int ft= ... ;
 
int at[planes] = ... ;
int elt[planes] = ... ; // earliest
int tlt[planes] = ... ; // target
int llt[planes] = ... ; // latest
float lbt[planes] = ... ;
float lat[planes] = ... ;
int st[planes][planes] = ... ;
 
// Decision Variables
// 		Continuous and non negative
dvar int+ x[planes];
dvar boolean y[planes][planes];


// Objective function
// 	creating the z variable will allow us to save the value of the optimal solution
// 	this is needed because we want to save this value in an excel file
dvar float f;
minimize f;

// Constraints
subject to
{
  f == sum (i in planes)( lbt[i] * maxl(0 , (tlt[i] - x[i])) + lat[i] * maxl(0, (x[i] - tlt[i])) ); // objective function

  forall (i in planes) {
    elt[i] <= x[i]; // lands within time window
    llt[i] >= x[i]; // lands within time window
    
    forall (j in planes) {
      if (j > i) { //symmetry
  		    y[i][j] + y[j][i] == 1 ; // one plane lands before the other  		       
  		    } 
      if (i!=j) {
  			x[j] >= x[i]+st[i][j]*y[i][j]-(llt[i]-elt[j])*y[j][i]; // separation between aircrafts
  			}
  	 }	  
  }    
}