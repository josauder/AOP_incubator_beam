package org.apache.beam.sdk.transforms;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by jonathan on 17.01.17.
 */
aspect Tracing {

    Logger logger = LoggerFactory.getLogger(this.getClass());
    String indent = "";

    pointcut transforms(): within(org.apache.beam.sdk.transforms.*);// || within(Circle) || within(Square);
    pointcut constructors(): execution(*.new(..)) && !within(Tracing) && transforms();
    pointcut methods(): transforms() && execution(* *(..));
    /**
    before() : preinitialization(*.new(..)) && !within(Tracing) && transforms() {
        System.out.println(thisJoinPointStaticPart);
    }

    before() : initialization(*.new(..)) && !within(Tracing) && transforms(){
        System.out.println(thisJoinPointStaticPart);
    }

    before() : call(*.new(..)) && !within(Tracing) && transforms(){
        System.out.println(thisJoinPointStaticPart);
    }

    before() : execution(*.new(..)) && !within(Tracing) && transforms(){
        System.out.println(thisJoinPointStaticPart);
    }**/

    before (): constructors() {
        System.out.println(indent + thisJoinPointStaticPart.getSignature());
        indent+="   ";
    }
    after(): constructors() {
    //    System.out.println(indent + "RETURN CONSTRUCTOR: " + thisJoinPointStaticPart.getSignature());
        indent=indent.substring(0,indent.length()-3);
    }

    before (): methods() {
        System.out.println(indent + thisJoinPointStaticPart.getSignature());
        indent+="   ";
    }
    after(): methods() {
    //    System.out.println(indent + "RETURN METHOD:" + thisJoinPointStaticPart.getSignature());
        indent=indent.substring(0,indent.length()-3);
    }
/**
     aspect GetInfo {

     static final void println(String s){ System.out.println(s); }

     pointcut goCut(): cflow(this(Demo) && execution(void go()));

     pointcut demoExecs(): within(Demo) && execution(* *(..));

     Object around(): demoExecs() && !execution(* go()) && goCut() {
     println("Intercepted message: " +
     thisJoinPointStaticPart.getSignature().getName());
     println("in class: " +
     thisJoinPointStaticPart.getSignature().getDeclaringType().getName());
     printParameters(thisJoinPoint);
     println("Running original method: \n" );
     Object result = proceed();
     println("  result: " + result );
     return result;
     }

     static private void printParameters(JoinPoint jp) {
     println("Arguments: " );
     Object[] args = jp.getArgs();
     String[] names = ((CodeSignature)jp.getSignature()).getParameterNames();
     Class[] types = ((CodeSignature)jp.getSignature()).getParameterTypes();
     for (int i = 0; i < args.length; i++) {
     println("  "  + i + ". " + names[i] +
     " : " +            types[i].getName() +
     " = " +            args[i]);
     }
     }
     */
}
