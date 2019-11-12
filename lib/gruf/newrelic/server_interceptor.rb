# frozen_string_literal: true

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
require 'new_relic/agent'
require 'new_relic/agent/distributed_tracing'

module Gruf
  module Newrelic
    ##
    # New Relic transaction tracing for Gruf endpoints
    #
    class ServerInterceptor < ::Gruf::Interceptors::ServerInterceptor
      include ::NewRelic::Agent::Instrumentation::ControllerInstrumentation

      def call
        opts = {
          category: Gruf::Newrelic.server_category,
          class_name: request.service,
          name: request.method_key
        }

        # Yield to the given block with NewRelic tracing.
        # http://www.rubydoc.info/github/newrelic/rpm/NewRelic%2FAgent%2FInstrumentation%2FControllerInstrumentation:perform_action_with_newrelic_trace
        perform_action_with_newrelic_trace(opts) do
          accept_distributed_tracing
          yield
        end
      end

      private

      def accept_distributed_tracing
        payload = request.active_call.metadata[NEWRELIC_TRACE_HEADER]
        ::NewRelic::Agent::DistributedTracing.accept_distributed_trace_payload(payload)
      end
    end
  end
end
