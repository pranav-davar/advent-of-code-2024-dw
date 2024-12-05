%dw 2.0
output application/json
var payload=(readUrl("classpath://day4.txt",'text/plain') splitBy "\n") map ($$):$ splitBy  ""
var row= sizeOf(payload)
var col=sizeOf(payload."0"[0])
// part1
var x=[0 , 0, 1,1 , 1, -1,-1, -1]
var y=[1 ,-1, 0,1 ,-1,  0, 1, -1]
var search=["X","M","A","S"]
fun check(a,b,dir,s)=
// payload["$(b+y[dir])"][0][a+x[dir]]
if(s<sizeOf(search))
    if(a<0 or b<0)
        false
    else
    if(a>=col or b>=row)
        false
    else
    if(payload["$(b)"][0][a]==search[s])
        check(a+x[dir],b+y[dir],dir,s+1)
    else
        false
else
    true
fun checkDir(a,b,dir,s=0,o=0)=
if(dir<8)
    if(check(a,b,dir,s))
        checkDir(a,b,dir+1,s,o+1)
    else
        checkDir(a,b,dir+1,s,o)
else 
    o
// end of part1 functions
//Part 2
fun part2Check(a,b)=
if(payload."$(b)"[0][a]=='A')
if(a-1<0 or b-1<0)  
    false
else 
if(a+1>=row or b+1>=col)
    false
else
if(payload."$(b+1)"[0][a-1]==payload."$(b-1)"[0][a+1])
false
else
([payload."$(b+1)"[0][a-1] default "",
payload."$(b+1)"[0][a+1] default "",
payload."$(b-1)"[0][a+1] default "",
payload."$(b-1)"[0][a-1] default ""] orderBy $) == ["M","M","S","S"]
else
false
---
{
    part1:((0 to col-1) map(v,k)-> ((0 to row-1) reduce(it,acc=0)->checkDir(it,v,0)+acc)) then sum($),
    part2:((0 to col-1) map(v,k)-> ((0 to row-1) reduce(it,acc=0)->if(part2Check(it,v)) acc+1 else acc)) then sum($)
}