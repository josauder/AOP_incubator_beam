package org.apache.beam.aspects;

import org.apache.beam.sdk.Pipeline;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
 * Created by jonathan on 10.01.17.
 */

aspect LoggingAspect {
    pointcut aspects() : within(org.apache.beam.aspects.*);
    pointcut project() : within(org.apache.beam.*.*) && !aspects();
    pointcut pipeline(org.apache.beam.sdk.Pipeline p) : this(p)  && project();
    pointcut coderRegistry(org.apache.beam.sdk.coders.CoderRegistry r) : this(r) && project();

    before (org.apache.beam.sdk.Pipeline p,
            java.lang.String s,
            org.apache.beam.sdk.values.PInput in,
            org.apache.beam.sdk.transforms.PTransform t):
            pipeline(p) && call(* pushNode(..)) && args(s,in,t) {
        LoggerFactory.getLogger(p.getClass()).info("Adding {} to {}", t, p);
    }

    before(org.apache.beam.sdk.Pipeline p) : pipeline(p) && execution(* run()) {
        LoggerFactory.getLogger(Pipeline.class).info("Running {} via {}", p, p.getRunner()) ;
    }


    Object around(org.apache.beam.sdk.coders.CoderRegistry r) :
            coderRegistry(r) &&
            call(* getDefaultCoder(..)) {
        Object o = proceed(r);
        LoggerFactory.getLogger(r.getClass()).info("Default coder for {}: {}", r, o);
        return o;
    }

    before(org.apache.beam.sdk.coders.CoderRegistry r) : coderRegistry(r) {
        LoggerFactory.getLogger(r.getClass()).info(r+""+thisJoinPoint.getSignature());
    }

    after(org.apache.beam.sdk.coders.CoderRegistry r,
            java.lang.Class c) :
            coderRegistry(r) && execution(* getDefaultCoderFactory(..)) && args(c) {
        LoggerFactory.getLogger(r.getClass()).info("Default coder for {} found by factory", c);
    }

    /*
    void around(org.apache.beam.sdk.io.Sink.WriteOperation op) :
            target(op) && call(void initialize(..)) && project() {
        Logger LOG= LoggerFactory.getLogger(op.getClass());
        LOG.info("Initializing write operation {}", op);
        op.initialize(c.getPipelineOptions());
        LOG.debug("Done initializing write operation {}", op);
    }*/


    /*
      LOG.info("Finalizing write operation {}.", writeOperation);
              List<WriteT> results = Lists.newArrayList(c.sideInput(resultsView));
              LOG.debug("Side input initialized to finalize write operation {}.", writeOperation);
     */


    /*
          LOG.info("Opening writer for write operation {}", writeOperation);
          writer = writeOperation.createWriter(c.getPipelineOptions());
          writer.open(UUID.randomUUID().toString());
          LOG.debug("Done opening writer {} for operation {}", writer, writeOperationView);
     */


}