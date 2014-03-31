simplelib
=========

This project demonstrates how to create a Go (golang) package from a c++ class using [SWIG](http://www.swig.org/Doc3.0/Go.html)


#### Details

#####Building

	cd simplelib
	make

#####Installing

	make install

#####Running

	package main

	import (
		"fmt"
		"github.com/zacg/simplelib"
		)

	func main() {

		simpleClass := simplelib.NewSimpleClass()
		result := sc.Hello()
		fmt.Println(result)
	
	}
	
