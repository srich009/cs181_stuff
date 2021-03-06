#!/bin/bash

LINE="--------------------"

set -e

javac FieldFormat.java
javac DataDrawer.java
javac ArrayFormat.java
javac TxtDrawer.java

echo $LINE

javac Test1.java && java Test1    # PASS

echo $LINE

javac Test2.java && java Test2    # PASS

echo $LINE

javac Test3.java && java Test3    # PASS

echo $LINE

javac Test4.java && java Test4    # PASS

echo $LINE

javac Test5.java && java Test5    # PASS

echo $LINE

javac Test6.java && java Test6    # PASS

echo $LINE

javac Test7.java && java Test7    # PASS

echo $LINE

javac Test8.java && java Test8    # PASS

echo $LINE

java Test8 | dot -Tpng > p.png
