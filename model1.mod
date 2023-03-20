/*********************************************
 * OPL 22.1.1.0 Model
 * Author: luish
 * Creation Date: 26/12/2022 at 14:18:41
 *********************************************/

 int R=3;
 range runway=1..R;
 int p=...;
 range plane=1..p;
 int ft=...;
 float at[plane]=...;
 float elt[plane]=...;
 float tlt[plane]=...;
 float llt[plane]=...;
 float lbt[plane]=...;
 float lat[plane]=...;
 float st[plane][plane]=...;
 
 
 dvar float+ a[plane];
 dvar float+ b[plane];
 dvar float+ x[plane];
 dvar boolean d[plane];
 dvar boolean y[plane][plane];
 dvar boolean w[plane][runway];
 dvar boolean z[plane][plane];

 minimize sum(i in plane)(lbt[i]*b[i]+lat[i]*a[i]);
 subject to
 {
   forall (i in plane) {
		const1: a[i] <= (1-d[i])*10^8;
		const2: b[i] <= d[i]*10^8;
		const3: x[i] >= elt[i];
		const4: x[i] <= llt[i];
		//const5: x[i] >= at[i];
		const6: x[i] == tlt[i]+a[i]-b[i];
		const7: sum(r in runway) w[i][r] == 1;
        //const: x[i]-at[i]<=ft;
   }   
   forall (i in plane) {
   		forall (j in plane) {
   			if (i!=j) {
   		const9: x[i]-x[j] >= st[j][i]*z[i][j]-y[i][j]*10^8;
		const10: x[j]-x[i] >= st[i][j]*z[i][j]-(1-y[i][j])*10^8;
		const14: y[i][j]+y[j][i] == 1;
		//const13: y[i][j] >= 0;
		    if (j>i) {
		        const11: z[i][j] == z[j][i];
		        forall (r in runway) {
   		              const12: z[i][j] >= w[i][r]+w[j][r]-1;      
		      }
         }		   
     }	  
    }    
   }    
 }