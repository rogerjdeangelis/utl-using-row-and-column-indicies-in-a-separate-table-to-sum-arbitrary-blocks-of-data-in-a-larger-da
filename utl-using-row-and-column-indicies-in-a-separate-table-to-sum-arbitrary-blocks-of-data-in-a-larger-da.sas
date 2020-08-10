                                                                                                                                        
Using row and column indicies in a separate table to sum arbitrary blocks of data in a larger dataset                                   
                                                                                                                                        
This is an example of indirect addressing.                                                                                              
                                                                                                                                        
You need a matrix langauge for this type of problem.                                                                                    
                                                                                                                                        
                                                                                                                                        
   Three Solutions                                                                                                                      
                                                                                                                                        
        a. R                                                                                                                            
                                                                                                                                        
        b. Point                                                                                                                        
           Nice to have SAS solutions (Thanks Bart)                                                                                     
           Bartosz Jablonski                                                                                                            
           yabwon@gmail.com                                                                                                             
                                                                                                                                        
        c. curobs (SAS)                                                                                                                 
           Bartosz Jablonski                                                                                                            
           yabwon@gmail.com                                                                                                             
                                                                                                                                        
                                                                                                                                        
                                                                                                                                        
github                                                                                                                                  
https://tinyurl.com/y5q8y35x                                                                                                            
https://github.com/rogerjdeangelis/utl-using-row-and-column-indicies-in-a-separate-table-to-sum-arbitrary-blocks-of-data-in-a-larger-da 
                                                                                                                                        
StackOverflow                                                                                                                           
https://tinyurl.com/yy2bwyfz                                                                                                            
https://stackoverflow.com/questions/62999892/function-macro-to-get-a-value                                                              
                                                                                                                                        
options validvarname=upcase;                                                                                                            
libname sd1 "d:/sd1";                                                                                                                   
* Define input data with parameters;                                                                                                    
data sd1.indicies;                                                                                                                      
input row col rowend;                                                                                                                   
cards4;                                                                                                                                 
1 1 3                                                                                                                                   
2 2 5                                                                                                                                   
3 1 4                                                                                                                                   
;;;;                                                                                                                                    
run;quit;                                                                                                                               
                                                                                                                                        
SD1.INDICES total obs=3                                                                                                                 
                                                                                                                                        
Obs   ROW  COL   ROWEND                                                                                                                 
                                                                                                                                        
 1     1    1       3                                                                                                                   
 2     2    2       5                                                                                                                   
 3     3    1       4                                                                                                                   
                                                                                                                                        
* Define values table;                                                                                                                  
data sd1.values;                                                                                                                        
input val1 val2 val3;                                                                                                                   
cards4;                                                                                                                                 
10  1  8                                                                                                                                
0   4  1                                                                                                                                
4   6  1                                                                                                                                
6   5  2                                                                                                                                
10  5  6                                                                                                                                
;;;;                                                                                                                                    
run;quit;                                                                                                                               
                                                                                                                                        
                                                                                                                                        
SD1.VALUES total obs=5                                                                                                                  
                                                                                                                                        
  VAL1    VAL2    VAL3                                                                                                                  
                                                                                                                                        
   10       1       8                                                                                                                   
    0       4       1                                                                                                                   
    4       6       1                                                                                                                   
    6       5       2                                                                                                                   
   10       5       6                                                                                                                   
                                                                                                                                        
/*          _                                                                                                                           
 _ __ _   _| | ___  ___                                                                                                                 
| `__| | | | |/ _ \/ __|                                                                                                                
| |  | |_| | |  __/\__ \                                                                                                                
|_|   \__,_|_|\___||___/                                                                                                                
                                                                                                                                        
*/                                                                                                                                      
                                                                                                                                        
Condside the first rows of indices                                                                                                      
                                                                                                                                        
  ROW    = 1                                                                                                                            
  COL    = 1                                                                                                                            
  ROWEND = 3                                                                                                                            
                                                                                                                                        
  VALUES[1,1]=10                                                                                                                        
                                                                                                                                        
  Sum to ROWEND = 3                                                                                                                     
                                                                                                                                        
  VALUES[1,1] + VALUES[2,1] + VALUES[3,1]  = 10 + 0 +4 = 14                                                                             
                                                                                                                                        
  Basically we start at values[row,col] and sum to values[rowend,col]                                                                   
                                                                                                                                        
/*           _               _                                                                                                          
  ___  _   _| |_ _ __  _   _| |_                                                                                                        
 / _ \| | | | __| `_ \| | | | __|                                                                                                       
| (_) | |_| | |_| |_) | |_| | |_                                                                                                        
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                                       
                |_|                                                                                                                     
*/                                                                                                                                      
                                                                                                                                        
Up to 40 obs from WANT total obs=3                                                                                                      
                                                                                                                                        
Obs    VAR1    VAR2    VAR3    TOT                                                                                                      
                                                                                                                                        
 1       1       1       3      14                                                                                                      
 2       2       2       5      20                                                                                                      
 3       3       1       4      10                                                                                                      
                                                                                                                                        
                                                                                                                                        
/*         _       _   _                                                                                                                
 ___  ___ | |_   _| |_(_) ___  _ __                                                                                                     
/ __|/ _ \| | | | | __| |/ _ \| `_ \                                                                                                    
\__ \ (_) | | |_| | |_| | (_) | | | |                                                                                                   
|___/\___/|_|\__,_|\__|_|\___/|_| |_|                                                                                                   
  ___                                                                                                                                   
|  _ \                                                                                                                                  
| |_) |                                                                                                                                 
|  _ <                                                                                                                                  
|_| \_\                                                                                                                                 
                                                                                                                                        
*/                                                                                                                                      
*/                                                                                                                                      
                                                                                                                                        
%utl_submit_r64(resolve('                                                                                                               
library(haven);                                                                                                                         
library(SASxport);                                                                                                                      
library(data.table);                                                                                                                    
indicies<-as.matrix(read_sas("d:/sd1/indicies.sas7bdat"));                                                                              
values<-as.matrix(read_sas("d:/sd1/values.sas7bdat"));                                                                                  
/* initialize vector with missings */                                                                                                   
tot <- rep(NA, nrow(indicies));                                                                                                         
/* loop by rows. Note indirect addressing */                                                                                            
for (r in c(1:nrow(indicies))) {                                                                                                        
  tot[r]=sum(values[indicies[r,1]:indicies[r,3],indicies[r,2]]);                                                                        
  };                                                                                                                                    
want<-as.data.table(tot);                                                                                                               
write.xport(want,file="d:/xpt/want.xpt");                                                                                               
'));                                                                                                                                    
                                                                                                                                        
libname xpt xport "d:/xpt/want.xpt";                                                                                                    
data want;                                                                                                                              
  merge have xpt.want;                                                                                                                  
run;quit;                                                                                                                               
libname xpt clear;                                                                                                                      
                                                                                                                                        
/*           _       _                                                                                                                  
 _ __   ___ (_)_ __ | |_                                                                                                                
| `_ \ / _ \| | `_ \| __|                                                                                                               
| |_) | (_) | | | | | |_                                                                                                                
| .__/ \___/|_|_| |_|\__|                                                                                                               
|_|                                                                                                                                     
*/                                                                                                                                      
                                                                                                                                        
data indicies;                                                                                                                          
input row col rowend;                                                                                                                   
cards4;                                                                                                                                 
1 1 3                                                                                                                                   
2 2 5                                                                                                                                   
3 1 4                                                                                                                                   
;;;;                                                                                                                                    
run;                                                                                                                                    
                                                                                                                                        
data values;                                                                                                                            
input val1 val2 val3;                                                                                                                   
cards4;                                                                                                                                 
10  1  8                                                                                                                                
0   4  1                                                                                                                                
4   6  1                                                                                                                                
6   5  2                                                                                                                                
10  5  6                                                                                                                                
;;;;                                                                                                                                    
run;                                                                                                                                    
                                                                                                                                        
proc transpose data = values out = want prefix = rows;                                                                                  
  var val:;                                                                                                                             
run;                                                                                                                                    
                                                                                                                                        
data want;                                                                                                                              
  set indicies;                                                                                                                         
                                                                                                                                        
  point = col; /* <- to keep "col" in dataset since "set want(keep = columns:) point = col;" drops "col" */                             
  set want(keep = rows:) point = point;                                                                                                 
                                                                                                                                        
  array DATA[*] rows: ; drop rows:;                                                                                                     
                                                                                                                                        
  result = 0;                                                                                                                           
  do _N_ = ROW to ROWEND;                                                                                                               
    result + DATA[_N_];                                                                                                                 
  end;                                                                                                                                  
run;                                                                                                                                    
proc print data = want;                                                                                                                 
run;                                                                                                                                    
                                                                                                                                        
                                                                                                                                        
/*                    _                                                                                                                 
  ___ _   _ _ __ ___ | |__  ___                                                                                                         
 / __| | | | `__/ _ \| `_ \/ __|                                                                                                        
| (__| |_| | | | (_) | |_) \__ \                                                                                                        
 \___|\__,_|_|  \___/|_.__/|___/                                                                                                        
                                                                                                                                        
*/                                                                                                                                      
                                                                                                                                        
data _null_;                                                                                                                            
  call symputX("NmbrOfVals", nobs);                                                                                                     
  stop; set indicies nobs = nobs;                                                                                                       
run;                                                                                                                                    
                                                                                                                                        
data want;                                                                                                                              
  array column[&NmbrOfVals.] _temporary_;                                                                                               
  array  start[&NmbrOfVals.] _temporary_;                                                                                               
  array    end[&NmbrOfVals.] _temporary_;                                                                                               
  array result[&NmbrOfVals.] _temporary_;                                                                                               
                                                                                                                                        
  do until (eof);                                                                                                                       
    set indicies end = eof curobs = curobs;                                                                                             
    column[curobs] = col;                                                                                                               
     start[curobs] = row;                                                                                                               
       end[curobs] = rowend;                                                                                                            
  end;                                                                                                                                  
                                                                                                                                        
  eof = 0;                                                                                                                              
  do until (eof);                                                                                                                       
    set values curobs = curobs end = eof;                                                                                               
    array val[*] val:;                                                                                                                  
                                                                                                                                        
    do _N_ = lbound(column) to hbound(column);                                                                                          
       result[_N_] + ifn( start[_N_] <= curobs <= end[_N_], val[column[_N_]], 0);                                                       
    end;                                                                                                                                
  end;                                                                                                                                  
                                                                                                                                        
  do _N_ = lbound(column) to hbound(column);                                                                                            
     col    = column[_N_];                                                                                                              
     row    = start[_N_];                                                                                                               
     rowend = end[_N_];                                                                                                                 
     res    = result[_N_];                                                                                                              
     output;                                                                                                                            
  end;                                                                                                                                  
                                                                                                                                        
  keep col row rowend res;                                                                                                              
  stop;                                                                                                                                 
run;                                                                                                                                    
                                                                                                                                        
proc print;                                                                                                                             
run;                                                                                                                                    
                                                                                                                                        
                                                                                                                                         
                                                                                                                                                                
                                                                                                                                                                
