%dw 2.0
import * from dw::core::Strings
output application/json
var payload=(((readUrl("classpath://day9.txt",'text/plain') splitBy  "") 
map (
    if($ != "0")
        if(($$ mod 2) !=0) 
        (1 to $) map '.' 
        else (1 to $) map(v,k)-> $$/2 
    else 
        ""
    ) )) then flatten ($) - ""
var arrayWS=payload - "."
var arrayWSLen=sizeOf(arrayWS)
fun part1()=
(0 to arrayWSLen-1) reduce (it, acc={
    c:-1,
    o:0})-> 
if(payload[it]=="."){
    c:acc.c-1,
    o:acc.o+ it*arrayWS[acc.c]
}
else
{
    c:acc.c,
    o:acc.o+ it*payload[it]
}
---
{
    part1:part1().o,
    part2:""
}