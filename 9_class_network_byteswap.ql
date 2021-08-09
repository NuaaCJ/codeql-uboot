import cpp
class NetworkByteSwap extends Expr{
    NetworkByteSwap(){
        exists(MacroInvocation m |
            m.getMacro().getName()=["ntohs","ntohl","ntohll"] and this=m.getExpr()
            )
    }
}
from NetworkByteSwap n
select n,"step9"
