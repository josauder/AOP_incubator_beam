package org.apache.beam.aspects;

import org.apache.beam.sdk.Pipeline;
import org.apache.beam.sdk.runners.TransformHierarchy;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
 * Created by jonathan on 10.01.17.
 */

aspect LoggingAspect {
    Logger logger = LoggerFactory.getLogger(this.getClass());

    pointcut project() : within(org.apache.beam.*.*) && !within(org.apache.beam.aspects.*);


    pointcut pipeline(org.apache.beam.sdk.Pipeline p) : this(p)  && project();

    pointcut pushNode(
            org.apache.beam.sdk.Pipeline p,
            java.lang.String s,
            org.apache.beam.sdk.values.PInput in,
            org.apache.beam.sdk.transforms.PTransform t):
        pipeline(p)
        && call(* pushNode(..))
        && args(s,in,t)
        //&& target(org.apache.beam.sdk.runners.TransformHierarchy)
       ;

    before (org.apache.beam.sdk.Pipeline p,
            java.lang.String s,
            org.apache.beam.sdk.values.PInput in,
            org.apache.beam.sdk.transforms.PTransform t): pushNode(p,s,in,t)  {//args(org.apache.beam.sdk.)  /*&& (!within(LoggingAspect))*/ {
        LoggerFactory.getLogger(p.getClass())
                .info("Adding {} to {}", t, p);

        //    .debug("Adding {} to {}", transform, this);

        //         logger.info(thisJoinPoint.getSignature().toString());
    }

    pointcut runPipeline(org.apache.beam.sdk.Pipeline p) : pipeline(p) && execution(* run());

    before(org.apache.beam.sdk.Pipeline p) : runPipeline(p) {
        LoggerFactory.getLogger(Pipeline.class).info("Running {} via {}", p, p.getRunner()) ;
    }

    /**   public interface Validable<T> {};
     declare parents: (View.AsSingleton<T> || View.AsIterable<T> || View.AsList<T>) implements Validable<T>;

     public void Validable.validate(PCollection<T> input) {
     try {
     GroupByKey.applicableTo(input);
     } catch (IllegalStateException e) {
     throw new IllegalStateException("Unable to create a side-input view from input", e);
     }
     }



     pointcut populateDisplayData(DisplayData.Builder builder) :
     call(ApproximateQuantiles.ApproximateQuantilesCombineFn<T, ComparatorT extends Comparator<T> & Serializable>
     .populateDisplayData(DisplayData.Builder) ||

     ApproximateUnique.Globally<T> extends PTransform<PCollection<T>, PCollection<Long>>
     .populateDisplayData(DisplayData.Builder) ||

     ApproximateUnique.PerKey<K, V> extends PTransform<PCollection<KV<K, V>>, PCollection<KV<K, Long>>>
     .populateDisplayData(DisplayData.Builder) ||
     );
     */
}