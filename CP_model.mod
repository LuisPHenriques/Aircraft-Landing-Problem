/*********************************************
 * OPL 22.1.0.0 Model
 * Author: luish
 * Creation Date: 02/01/2023 at 20:03:27
 *********************************************/

using CP;
 
 int R=2;
 range runway=1..R;
 int p=...;
 range plane=1..p;
 int ft=...;
 float at[plane]=...;
 int elt[plane]=...;
 int tlt[plane]=...;
 int llt[plane]=...;
 float lbt[plane]=...;
 float lat[plane]=...;
 int st[plane][plane]=...;

 
dvar int+ x[i in plane] in elt[i]..llt[i];
 dvar boolean d[plane];
 dvar boolean y[plane][plane];
 dvar boolean w[plane][runway];
 dvar boolean z[plane][plane];

execute{
		cp.param.timeLimit=30*60;
}


/*execute
{
   	var f = cp.factory;

	//var phase1 = f.searchPhase(houseOrder,
		//			f.selectSmallest(f.domainSize()),
			//		f.selectLargest(f.value()));

	var phase1 = f.searchPhase(x,
					f.selectLargest(f.impact()),
					f.selectLargest(f.value()));
	cp.setSearchPhases(phase1);

	cp.param.SearchType = "DepthFirst";
}*/


 minimize sum(i in plane)((1-d[i])*lbt[i]*(tlt[i]-x[i])+d[i]*lat[i]*(x[i]-tlt[i]));
 subject to
 {
   allDifferent(x);
   forall (i in plane) {
     	const1: x[i] >= tlt[i] - (1-d[i])*10^8;
		const2: x[i] <= tlt[i] + d[i]*10^8;
		const3: sum(r in runway) w[i][r] == 1;
   		forall (j in plane) {
   			if (i!=j) {
   		const4: x[i]-x[j] >= st[j][i]*z[i][j]-y[i][j]*10^8;
		const5: x[j]-x[i] >= st[i][j]*z[i][j]-(1-y[i][j])*10^8;
     }
            if (j>i) {
		        const6: z[i][j] == z[j][i];
		        forall (r in runway) {
   		              const7: z[i][j] >= w[i][r]+w[j][r]-1;      
		      }
         }	
    }
   }
 }