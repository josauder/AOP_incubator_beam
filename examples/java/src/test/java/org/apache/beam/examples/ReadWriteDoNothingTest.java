package org.apache.beam.examples;

import org.apache.beam.sdk.Pipeline;
import org.apache.beam.sdk.coders.StringUtf8Coder;
import org.apache.beam.sdk.testing.PAssert;
import org.apache.beam.sdk.testing.RunnableOnService;
import org.apache.beam.sdk.testing.TestPipeline;
import org.apache.beam.sdk.transforms.Create;
import org.apache.beam.sdk.transforms.MapElements;
import org.apache.beam.sdk.values.PCollection;
import org.junit.Test;
import org.junit.experimental.categories.Category;

import java.util.Arrays;
import java.util.List;

/**
 * Created by jonathan on 18.01.17.
 */
public class ReadWriteDoNothingTest {


    static final String[] WORDS_ARRAY = new String[] {
            "hi"};

    static final List<String> WORDS = Arrays.asList(WORDS_ARRAY);

    static final String[] COUNTS_ARRAY = new String[] {
            "hi: 1"};

    @Test
    @Category(RunnableOnService.class)
    public void testCountWords() throws Exception {
        Pipeline p = TestPipeline.create();

        PCollection<String> input = p.apply(Create.of(WORDS).withCoder(StringUtf8Coder.of()));

        PCollection<String> output = input.apply(new WordCount.CountWords())
                .apply(MapElements.via(new WordCount.FormatAsTextFn()));
        //PAssert.that(output).containsInAnyOrder(COUNTS_ARRAY);
        p.run().waitUntilFinish();
    }
}
