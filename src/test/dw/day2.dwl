%dw 2.0
import * from dw::core::Arrays
output application/json
var payload=((readUrl('classpath://day2.txt','text/plain') splitBy "\n"))
fun cond(inp1,inp0)= if(inp1 as Number>inp0 as Number) "i" else (if(inp1 as Number <inp0 as Number) "d" else "e")
var diff=[1,2,3,-1,-2,-3]
fun safeR(report) = do {
  var s= sizeOf(report)-2
  var c= cond(report[1],report[0]) 
  ---
  if(c=='e')
    false
  else
   (0 to s) reduce ((item, accumulator=true) -> if(cond(report[item+1],report[item])==c and contains(diff,report[item]-report[item+1])) accumulator else false)
}
fun safeR3(inp)=
if(safeR(inp))
true
else
do {
  var l=sizeOf(inp)-2
  ---
  if(safeR(inp[1 to -1]))
    true
  else
  if(safeR(inp[0 to l]))
  true
  else
  (1 to l) reduce(it1,acc=false)-> if (safeR((inp[0 to it1-1] ++ inp[it1+1 to -1]))) true else acc
  
}
---
{
  part1: payload countBy safeR($ splitBy " "),
  part2: payload countBy safeR3($ splitBy  " ")
}