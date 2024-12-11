%dw 2.0
output application/json
var payload=((readUrl("classpath://day10.txt","text/plain") splitBy "\n") map(v1,y)-> v1 splitBy "" map(v2,x)->{
    v:v2 as Number,
    x:x,
    y:y
}) then flatten($)
var xd=[1,-1,0,0]
var yd=[0,0,1,-1]
var side=pow(sizeOf(payload),0.5)
fun findAllDir(num=0,x=0,y=0,out=[])=
if(num==9)
[{x:x,y:y,v:num}]
else
(0 to 3) reduce(it,acc=[])-> 
(
    if((x+xd[it]>=side) or (y+yd[it]>=side) or (x+xd[it]<0) or (y+yd[it]<0))
     acc
    else
    if(num+1==payload[?($.x==x+xd[it] and $.y==y+yd[it])][0].v)
       //findAllDir(num+1,x+xd[it],y+yd[it],{t:out.t})
       acc ++ findAllDir(num+1,x+xd[it],y+yd[it],out ++ [{x:x+xd[it],y:y+yd[it],v:num+1}])
    else
     acc
)
---
{
    part1:(payload map(v,k)-> if(v.v==0) sizeOf(findAllDir(0,v.x,v.y,[]) distinctBy $) else 0 )then sum($),
    part2:(payload map(v,k)-> if(v.v==0) sizeOf(findAllDir(0,v.x,v.y,[])) else 0 )then sum($)
}
//payload[?($.x==2 and $.y==0)][0].v