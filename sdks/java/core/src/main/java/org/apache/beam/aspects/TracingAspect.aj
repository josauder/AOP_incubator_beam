package org.apache.beam.aspects;

import org.aspectj.lang.Signature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by jonathan on 17.01.17.
 */
aspect TracingAspect {
    pointcut aspects(): within (org.apache.beam.aspects.*);
    pointcut project(): within (org.apache.beam.*.*) && !aspects();
    pointcut constructors(): call(*.new(..)) && project();
    pointcut methods(): project() && call(* *(..));

    Tree<Signature> tree = new Tree<>(null, null);
    Tree<Signature> currentNode = tree;

    Object around (): constructors() || methods() {
        Signature sig = thisJoinPointStaticPart.getSignature();
        Tree<Signature> child;
        if ((child=currentNode.getChildWithValue(sig))==null) {
            child = new Tree<>(sig,currentNode);
        }
        currentNode = child;
        if (currentNode==tree) {
            System.out.println(tree);
        }
        currentNode.incrementCounter();
        Object o = proceed();
        currentNode = currentNode.getParent();
        return o;
    }
}
