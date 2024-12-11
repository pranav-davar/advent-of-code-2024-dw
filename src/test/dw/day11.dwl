%dw 2.0
output application/json
//var payload=readUrl('classpath://day11.txt','text/plain') splitBy (" ")
var payload="4189 413 82070 61 655813 7478611 0 8" splitBy (" ")

fun blink(num)=
if(num as Number ==0)
[1]
else
if((sizeOf(num) mod 2)==0)
[num[0 to sizeOf(num)/2 -1] as Number, num[sizeOf(num)/2 to -1] as Number]
else
[(num as Number)*2024]

fun blinkN(inpArr,c=0, n=2)=
if(c<n)
blinkN(inpArr reduce(it, acc=[])-> acc ++ blink(it),c+1,n)
else
inpArr
---
blinkN(payload,0,75) then sizeOf($)
