%dw 2.0
import * from dw::core::Strings
output application/json
var payload=replaceAll(readUrl("classpath://day3.txt","application/java"),"\n","")
fun extract(data)= (flatten(data scan  (/(?:mul\([0-9]{1,3},[0-9]{1,3}\))/))) reduce ((it, acc=0) -> acc + mul(flatten(it scan(/[0-9]{1,3}/))))
fun mul(a)= (a[0] as Number)*(a[1] as Number)
---
//payload
{
    part1: extract(payload),
    part2: extract((payload replace /(?:don't\(\))(.*?)(?=do\(\))/ with "" )as String)
}