%dw 2.0
import * from dw::core::Strings
output application/json

var payload=(readUrl("classpath://day13.txt","text/plain") splitBy "\n\n") map (($ splitBy  "\n") map (($ splitBy ", ") map if(contains($,"+"))substringAfter($,"+") as Number else substringAfter($,"=") as Number))
// Cramer's rule for linear equation
fun calcD(a1,a2,b1,b2)=
a1*b2-a2*b1

fun calcDx(b1,b2,c1,c2)=
c1*b2-c2*b1

fun calcDy(a1,a2,c1,c2)=
a1*c2-a2*c1

fun calcVal(a1,b1,c1,a2,b2,c2)=
do{
    var D=calcD(a1,a2,b1,b2)
    var Dx=calcDx(b1,b2,c1,c2)
    var Dy=calcDy(a1,a2,c1,c2)
    ---
    if(D != 0 and (Dx mod D)==0 and (Dy mod D)==0 and Dx/D<100 and Dy/D<100)
    3*Dx/D+ Dy/D
    else
    0
}
fun calcVal2(a1,b1,c1,a2,b2,c2)=
do{
    var D=calcD(a1,a2,b1,b2)
    var Dx=calcDx(b1,b2,c1,c2)
    var Dy=calcDy(a1,a2,c1,c2)
    ---
    if(D != 0 and (Dx mod D)==0 and (Dy mod D)==0)
    3*Dx/D+ Dy/D
    else
    0
}

---
{
    part1:sum(payload map calcVal($[0][0],$[1][0],$[2][0],$[0][1],$[1][1],$[2][1])),
    part2:sum(payload map calcVal2($[0][0],$[1][0],$[2][0]+10000000000000,$[0][1],$[1][1],$[2][1]+10000000000000))
}