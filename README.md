simplelib
=========

This project demonstrates how to create a Go (golang) package from a C++ class using [SWIG](http://www.swig.org/Doc3.0/Go.html).

This code was originally for a blog post here:
[http://zacg.github.io/blog/2013/06/06/calling-c-plus-plus-code-from-go-with-swig/](http://zacg.github.io/blog/2013/06/06/calling-c-plus-plus-code-from-go-with-swig/),
but the instructions refer to earlier versions of Go (before 1.5) and
SWIG (before 3.0).

#####Getting Started

    cd $GOPATH
	go get github.com/zacg/simplelib
    cd $GOPATH/src/github.com/zacg/simplelib
	go install -x
    go test -v


#####Generating simplelib.go and simplelib_wrap.cxx

These files are needed by simplelib_test.go. You need to do this each time the dependent \*.h or \*.cpp files change.

    swig -go -cgo -c++ -intgosize 64 simplelib.i

To clean up the auto-generated files:

    \rm -f simplelib.go simplelib_wrap.cxx 
    

#####Example Application Code that uses simplelib.go and simplelib_wrap.cxx

You an also look at the unit tests in `simplelib_test.go`.

```go
package main

import (
	"fmt"
	"github.com/zacg/simplelib"
)

func main() {

	simpleClass := simplelib.NewSimpleClass()
	result := simpleClass.Hello()
	fmt.Println(result)

	strings := simplelib.NewStringVector()
	simpleClass.HelloString(strings)

	var i int64
	for i = 0; i < strings.Size(); i++ {
		fmt.Println(strings.Get(int(i)))
	}

	bytes := simplelib.NewByteVector()
	simpleClass.HelloBytes(bytes)

	for i = 0; i < bytes.Size(); i++ {
		fmt.Printf("%c", bytes.Get(int(i)))
	}
	fmt.Println("")

}
```	
