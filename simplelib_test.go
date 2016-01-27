package simplelib_test

import (
	"github.com/zacg/simplelib"
	"testing"
)

func TestHello(t *testing.T) {
	c := simplelib.NewSimpleClass()
	s := c.Hello()
	if s != "world" {
		t.Error("unexpected value: ", s)
	}
}

func TestHelloString(t *testing.T) {
	c := simplelib.NewSimpleClass()
	v := simplelib.NewStringVector()
	c.HelloString(v)
	c.HelloString(v)
	if v.Size() != 2 {
		t.Error("incorrect size: ", v)
	}
}

func TestHelloBytes(t *testing.T) {
	c := simplelib.NewSimpleClass()
	v := simplelib.NewByteVector()
	c.HelloBytes(v)
	c.HelloBytes(v)
	if v.Size() != 10 {
		t.Error("incorrect size: ", v)
	}
}
