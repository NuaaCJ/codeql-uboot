/**
 * @kind path-problem
 */

import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph

class NetworkByteSwap extends Expr {
  NetworkByteSwap(){
    exists(MacroInvocation m |
        m.getMacro().getName()=["ntohs","ntohl","ntohll"] and this=m.getExpr()
        )
  }
}

class Config extends TaintTracking::Configuration {
  Config() { this = "NetworkToMemFuncLength" }

  override predicate isSource(DataFlow::Node source) {
    source.asExpr() instanceof NetworkByteSwap 
  }
  override predicate isSink(DataFlow::Node sink) {
    exists(FunctionCall ca |
    ca.getTarget().getName()="memcpy" and sink.asExpr()=ca.getArgument(2) and not ca.getArgument(0).isConstant()
        )
  }
}

from Config cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink, source, sink, "Network byte swap flows to memcpy"
