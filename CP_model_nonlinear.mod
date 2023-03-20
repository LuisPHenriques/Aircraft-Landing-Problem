/*********************************************
 * OPL 22.1.0.0 Model
 * Author: luish
 * Creation Date: 09/01/2023 at 18:21:03
 *********************************************/
using CP;
 
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
 
 
  
  
/*execute {
  cp.param.FailLimit = 3000000;
}*/

execute{
        //cp.param.FailLimit = 3000000;
		cp.param.timeLimit=30*60;
		//cp.param.SearchType = 27;
		
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
		const1: (1-d[i])*x[i] <= tlt[i];
		const2: x[i] >= d[i]*tlt[i];
   }
      
   forall (i in plane) {
   		forall (j in plane) {
   			if (i!=j) {

   		const9: (x[i]-x[j])*(1-y[i][j]) >= st[j][i]*(1-y[i][j]);
		const10: (x[j]-x[i])*y[i][j] >= st[i][j]*y[i][j];
		
		
     }	  
    }    
   }    
 }