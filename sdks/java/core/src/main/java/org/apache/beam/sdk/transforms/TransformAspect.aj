package org.apache.beam.sdk.transforms;

import org.apache.beam.sdk.transforms.display.DisplayData;
import org.apache.beam.sdk.values.PCollection;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by jonathan on 10.01.17.
 */

aspect TransformAspect {
        Logger logger = LoggerFactory.getLogger(this.getClass());
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
        pointcut test() : //target(org.apache.beam.sdk.transforms.DoFn+) &&
                execution(* populateDisplayData(..)) && within(org.apache.beam.sdk.transforms.PTransform+) ;
  //      public pointcut test() : call(* *.DoFn+.*(**));
        before (): test() /*&& (!within(TransformAspect))*/ {
       //         logger.info(thisJoinPoint.getSignature().toString());
        }
}