
package org.apache.beam.examples;
import org.junit.Test;
/**
 * Created by jonathan on 06.12.16.
 */
public class AspectTest {


    @Test
    public void test() {
        InstantiationTest t= new InstantiationTest();
        t.innerTest();
        System.out.println("abcd");
    }
}
