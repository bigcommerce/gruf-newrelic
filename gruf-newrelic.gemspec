# Copyright (c) 2018-present, BigCommerce Pty. Ltd. All rights reserved
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
# documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit
# persons to whom the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the
# Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
# WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
# OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
$:.push File.expand_path('../lib', __FILE__)
require 'gruf/newrelic/version'

Gem::Specification.new do |spec|
  spec.name          = 'gruf-newrelic'
  spec.version       = Gruf::Newrelic::VERSION
  spec.authors       = ['Shaun McCormick']
  spec.email         = ['splittingred@gmail.com']

  spec.summary       = %q{Plugin for New Relic for gruf}
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/bigcommerce/gruf-new-relic'
  spec.license       = 'MIT'

  spec.files         = Dir['README.md', 'CHANGELOG.md', 'CODE_OF_CONDUCT.md', 'lib/**/*', 'gruf-new-relic.gemspec']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '< 3'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.7'
  spec.add_development_dependency 'pry'

  spec.add_runtime_dependency 'newrelic_rpm', '~> 6'
end
