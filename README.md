# gruf-newrelic - New Relic support for gruf

[![CircleCI](https://circleci.com/gh/bigcommerce/gruf-newrelic/tree/master.svg?style=svg)](https://circleci.com/gh/bigcommerce/gruf-newrelic/tree/master) [![Gem Version](https://badge.fury.io/rb/gruf-newrelic.svg)](https://badge.fury.io/rb/gruf-newrelic) [![Inline docs](http://inch-ci.org/github/bigcommerce/gruf-newrelic.svg?branch=master)](http://inch-ci.org/github/bigcommerce/gruf-newrelic)

Adds New Relic support for [gruf](https://github.com/bigcommerce/gruf) 2.0.0+.

## Installation

```ruby
gem 'gruf-newrelic'
```

In your gruf initializer:

```ruby
Gruf.configure do |c|
  c.interceptors.use(Gruf::Newrelic::ServerInterceptor)
end
```

This will add New Relic tracing support to all gruf controllers.

## License

Copyright (c) 2018-present, BigCommerce Pty. Ltd. All rights reserved 

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
documentation files (the "Software"), to deal in the Software without restriction, including without limitation the 
rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit 
persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the 
Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE 
WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR 
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
