package org.apache.beam.aspects;

import org.slf4j.LoggerFactory;

/**
 * Created by jonathan on 19.01.17.
 */
public aspect ExtensionAspect {

     pointcut transforms() : within(org.apache.beam.sdk.transforms.PTransform+);
     /*public interface Validable<T> {};
     declare parents: (View.AsSingleton<T> || View.AsIterable<T> || View.AsList<T>) implements Validable<T>;

     public void Validable.validate(PCollection<T> input) {
     try {
     GroupByKey.applicableTo(input);
     } catch (IllegalStateException e) {
     throw new IllegalStateException("Unable to create a side-input view from input", e);
     }
     }
     */

     pointcut populateDisplayData(org.apache.beam.sdk.transforms.PTransform t) :
             this(t) && call(* populateDisplayData());

     before(org.apache.beam.sdk.transforms.PTransform t)  : populateDisplayData(t) {
          LoggerFactory.getLogger(t.getClass()).info(thisJoinPoint.getSignature()+"");
     }
     /*call(ApproximateQuantiles.ApproximateQuantilesCombineFn<T, ComparatorT extends Comparator<T> & Serializable>
          .populateDisplayData(DisplayData.Builder) ||

     ApproximateUnique.Globally<T> extends PTransform<PCollection<T>, PCollection<Long>>
     .populateDisplayData(DisplayData.Builder) ||

     ApproximateUnique.PerKey<K, V> extends PTransform<PCollection<KV<K, V>>, PCollection<KV<K, Long>>>
     .populateDisplayData(DisplayData.Builder) ||
     );*/

}
