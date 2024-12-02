import countBy from dw::core::Arrays
output application/json
var payload=((readUrl('classpath://day1.txt','text/plain') splitBy "\n"))
var a1=payload map ($ splitBy "   ")[0] orderBy $
var a2=payload map ($ splitBy "   ")[1] orderBy $

---
{
    part1:(0 to sizeOf(a1)-1) reduce(it, acc=0)-> acc + abs(a2[it]-a1[it]),
    part2: a1 reduce(it, acc=0) -> (acc + it*(a2 reduce(it1,acc1=0)-> if(it1==it) acc1+1 else acc1))
}