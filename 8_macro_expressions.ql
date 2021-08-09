import cpp
from MacroInvocation mi
where mi.getMacro().getName()=["ntohs","ntohl","ntohll"]
select mi.getExpr(),"step8"