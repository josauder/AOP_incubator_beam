package org.apache.beam.examples;

public aspect Aspect {
    before(InstantiationTest te) : target(te) && (call(void innerTest())) {
        int i=0;
        int b=1;
        int c = i*b;
        System.out.println(c);
    }
}