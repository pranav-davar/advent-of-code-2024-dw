%dw 2.0
output application/json
var payload=readUrl("classpath://day5.txt","text/plain") splitBy "\n\n"
var rules=(payload[0] splitBy "\n") map ({($ splitBy ('|') map {($$):$} )})
var pageUpdates=payload[1] splitBy "\n"
fun part1()=(pageUpdates map(v1,k1)-> 
do{
var t=v1 splitBy  ","
---
if(!((0 to sizeOf(t)-2) reduce(k,acc=false)-> if(sizeOf(t[k+1 to sizeOf(t)-1]) > sizeOf(t[k+1 to sizeOf(t)-1]--(rules[?($."1"==t[k])]."0" default [])  )) true else acc))
t[sizeOf(t)/2] as Number
else 0
}) then sum($)
var h=("47,29,75,97,13" splitBy ",")
fun sortData(inpArr,start)=
(inpArr[start]):sizeOf(inpArr[0 to start]) > sizeOf(inpArr[0 to start] -- (rules[?(inpArr[start]==$."0")]."1" default []))
---
{ 
    part1:sortData(h,4),
    part2:""
}