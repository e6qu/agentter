// This file is auto-generated, don't edit it. Thanks.
// Description:
// 
// Minimal Darabonba module: one DSL source, generated into many languages.
package client

import (
  "github.com/alibabacloud-go/tea/tea"
)

// A data shape (compiles to a class/struct + (de)serialization per language).
type Greeting struct {
  Message *string `json:"message,omitempty" xml:"message,omitempty" require:"true"`
  Count *int32 `json:"count,omitempty" xml:"count,omitempty" require:"true"`
}

func (s Greeting) String() string {
  return tea.Prettify(s)
}

func (s Greeting) GoString() string {
  return s.String()
}

func (s *Greeting) SetMessage(v string) *Greeting {
  s.Message = &v
  return s
}

func (s *Greeting) SetCount(v int32) *Greeting {
  s.Count = &v
  return s
}


// Imperative logic written directly in the DSL — this is Alibaba's
// "customization = code in the spec" mechanism in miniature.
func Build (name *string) (_result *Greeting) {
  g := &Greeting{
    Message: name,
    Count: tea.Int32(1),
  }
  _result = g
  return _result
}

