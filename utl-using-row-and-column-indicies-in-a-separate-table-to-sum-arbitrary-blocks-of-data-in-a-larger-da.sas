Using row and column indicies in a separate table to sum arbitrary blocks of data in a larger dataset                                                           
                                                                                                                                                                
This is an example of indirect addressing.                                                                                                                      
                                                                                                                                                                
You need a matrix langauge for this type of problem.                                                                                                            
                                                                                                                                                                
Datastep arrays is not quite as clean.                                                                                                                          
HASH                                                                                                                                                            
                                                                                                                                                                
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
                                                                                                                                                                
                                                                                                                                                                
                                                                                                                                                                
