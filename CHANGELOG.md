Changelog for the gruf-newrelic gem.

### Pending Release

- Ruby 3 support, remove support for Ruby < 2.6
- Loosen gem dependencies, add bundler 2 support

### 1.3.0

- Allow customization of transaction name prefix [#7]

### 1.2.1

- Fix issue with NewRelic trace headers when they are arrays 

### 1.2.0

- Added ClientInterceptor with New Relic Distributed tracing support
- Refactored ServerInterceptor with New Relic Distributed tracing support

### 1.1.0

- Bump newrelic gem dependency to ~> 6
- Drop Ruby 2.2 support
- Update bundler support

### 1.0.0

- Initial public release
