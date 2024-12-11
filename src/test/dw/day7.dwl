%dw 2.0
output application/json
fun calcVal(inp=[81,40,27])=
do{
    var n=sizeOf(inp) - 1
---
(0 to pow(2,n)-1) map ((0 to n-1) reduce(v,acc=inp[0])-> if((floor($/pow(2,v)) mod 2 )== 0)
acc*inp[v+1]
else
acc+inp[v+1]
)
}
fun calcVal2(inp=[81,40,27])=
do{
    var n=sizeOf(inp) - 1
---
(0 to pow(3,n)-1) map ((0 to n-1) reduce(v,acc=inp[0] as Number)-> if((floor($/pow(3,v)) mod 3 )== 0)
acc+(inp[v+1] as Number)
else
if((floor($/pow(3,v)) mod 3 )== 1)
acc*(inp[v+1] as Number)
else
(acc ++ (inp[v+1] as Number)) as Number
)
}
var payload=readUrl("classpath://day7.txt","text/plain")  splitBy "\n"

// var part1=
// (payload map (
//     do{
//     var row=($ splitBy  ": ")
//     ---
//     if(contains(calcVal((row[1] splitBy " ") map $ as Number),row[0] as Number))
//     row[0] as Number
//     else
//     0
//     }
//     )
// ) then sum($)

---
(payload map (
    do{
    var row=($ splitBy  ": ")
    ---
    if(contains(calcVal((row[1] splitBy " ") map $ as Number),row[0] as Number))
    row[0] as Number
    else
    if(contains(calcVal2(row[1]splitBy  " "),row[0] as Number))
    row[0] as Number
    else
    0
    }
    )
) then sum($)