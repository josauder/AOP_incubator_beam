package org.apache.beam.aspects;

import org.aspectj.lang.Signature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by jonathan on 17.01.17.
 */
aspect TracingAspect {

    Logger logger = LoggerFactory.getLogger(this.getClass());

    pointcut project(): within (org.apache.beam.*.*) && !within(org.apache.beam.aspects.*);
    pointcut constructors(): execution(*.new(..)) && project();
    pointcut methods(): project() && execution(* *(..));
    pointcut end(): project() && call(* run(..));

    //before() : preinitialization(*.new(..)) && !within(TracingAspect) && transforms() {
    //before() : initialization(*.new(..)) && !within(TracingAspect) && transforms(){

    Tree<Signature> tree = new Tree<>(null, null);
    Tree<Signature> currentNode = tree;

    Object around (): constructors() || methods() {
        Signature sig = thisJoinPointStaticPart.getSignature();
        Tree<Signature> child;
        if ((child=currentNode.getChildWithValue(sig))==null) {
            child = new Tree<>(sig,currentNode);
        }
        currentNode = child;
        currentNode.incrementCounter();
        Object o = proceed();
        currentNode = currentNode.getParent();
        return o;
    }

    after(): end() {
       System.out.println(tree);
    }

}
