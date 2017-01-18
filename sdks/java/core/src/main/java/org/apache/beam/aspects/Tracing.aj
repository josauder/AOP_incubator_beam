package org.apache.beam.aspects;

import org.aspectj.lang.Signature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by jonathan on 17.01.17.
 */
aspect Tracing {

    Logger logger = LoggerFactory.getLogger(this.getClass());

    pointcut project(): within (org.apache.beam.*.*);
    //pointcut transforms(): within(org.apache.beam.sdk.transforms.*);// || within(Circle) || within(Square);
    pointcut constructors(): execution(*.new(..)) && !within(org.apache.beam.aspects.Tracing) && project();
    pointcut methods(): project() && execution(* *(..));
    pointcut end(): project() && call(* run(..));

    //before() : preinitialization(*.new(..)) && !within(Tracing) && transforms() {
    //before() : initialization(*.new(..)) && !within(Tracing) && transforms(){

    Tree<Signature> tree = new Tree<>(null, null);
    Tree<Signature> currentNode = tree;

    Object around (): constructors() || methods() {
        Signature sig = thisJoinPointStaticPart.getSignature();
        System.out.println(sig);
        Tree<Signature> child;
        if ((child=currentNode.getChildWithValue(sig))==null) {
            child = new Tree<>(sig,currentNode);
        }
        currentNode = child;
        Object o = proceed();
        currentNode = currentNode.getParent();
        return o;

    }
    after(): constructors() {
    //    logger.info(indent + "RETURN CONSTRUCTOR: " + thisJoinPointStaticPart.getSignature());
    //    indent=indent.substring(0,indent.length()-3);
    }

    before (): methods() {
    //    logger.info(indent + thisJoinPointStaticPart.getSignature());
    //    indent+="   ";
    }
    after(): end() {
       System.out.println(currentNode);
        //    logger.info(indent + "RETURN METHOD:" + thisJoinPointStaticPart.getSignature());
        //    indent=indent.substring(0,indent.length()-3);
    }


}
