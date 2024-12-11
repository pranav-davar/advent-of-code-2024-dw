%dw 2.6
output application/json
var payload=flatten((readUrl("classpath://day6.txt", "text/plain") splitBy "\n") map(v,k)-> ((v splitBy ("")) map {x:$$ as Number,y:k as Number,data:$}) )
var col=max(payload.x as Array<Number>)
var row=max(payload.y as Array<Number>)
var xd=[0,1,0,-1]
var yd=[-1,0,1,0]
var start=payload[?($.data=='^')][0]
@TailRec()
fun getDirs(st, dir)=
if(st[-1].x+xd[dir]>col or st[-1].y+yd[dir]>row or st[-1].y+yd[dir]<0 or st[-1].x+xd[dir]<0)
st
else 
if(payload[?($.x==st[-1].x+xd[dir] and $.y==st[-1].y+yd[dir])][0].data=='#')
getDirs(st,(dir +1) mod 4 )
else
getDirs(st + {x:st[-1].x+xd[dir],y:st[-1].y+yd[dir]},dir )

@TailRec()
fun getDirsB(st, dir,o=0)=
if(st[-1].x+xd[dir]>col or st[-1].y+yd[dir]>row or st[-1].y+yd[dir]<0 or st[-1].x+xd[dir]<0)
o
else 
if(payload[?($.x==st[-1].x+xd[dir] and $.y==st[-1].y+yd[dir])][0].data=='#')
getDirsB(st,(dir +1) mod 4 ,o)
else
if(contains(st,{x:st[-1].x+xd[dir],y:st[-1].y+yd[dir]}))
getDirsB(st + {x:st[-1].x+xd[dir],y:st[-1].y+yd[dir]},dir ,o+1)
else
getDirsB(st + {x:st[-1].x+xd[dir],y:st[-1].y+yd[dir]},dir ,o)
---

{ 
    part1:(getDirsB([{x:start.x,y:start.y}],0)),
    part2:""
}
