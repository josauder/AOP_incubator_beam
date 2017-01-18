package org.apache.beam.aspects;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by jonathan on 18.01.17.
 */
public class Tree<K> {
    Tree<K> parent;
    K value;
    List<Tree<K>> children;

    public Tree(K value, Tree<K> parent) {
        //System.out.println("");
        this.value =value;
        this.parent = parent;
        if (parent != null) {
            this.parent.setChild(this);
        }
        this.children = new ArrayList<>();
    }

    public Tree<K> getParent() {
        return this.parent;
    }

    public Tree<K> getChildWithValue(K val) {
        for (Tree<K> c : children) {
            if (c.getValue().equals(val)) {
                return c;
            }
        }
        return null;
    }

    public void setChild(Tree<K> n) {
        this.children.add(n);
    }

    public List<Tree<K>> getChildren() {
        return this.children;
    }

    public K getValue() {
        return this.value;
    }

    @Override
    public String toString(){
        if (value == null) {
            return "Node(null)";
        }
        String out = "Node("+value.toString()+")";
        if (children.size()>0) {
            for (Tree<K> child : children) {
                out += child.toString();
            }
        }
        return out;
    }

}
