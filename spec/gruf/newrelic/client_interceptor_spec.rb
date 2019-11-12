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
require 'spec_helper'

describe Gruf::Newrelic::ClientInterceptor do
  let(:interceptor) { described_class.new }
  let(:nr_tracer) { ::NewRelic::Agent::DistributedTracing }
  let(:nr_header_data) { 'newrelic-header-data' }
  let(:nr_trace_instance) { instance_double(::NewRelic::Agent::DistributedTracePayload, http_safe: nr_header_data) }
  let(:request_context) { double(:request_context, metadata: {}) }
  subject { interceptor.call(request_context: request_context){ true } }

  describe '.call' do
    it 'yields' do
      expect(interceptor).to receive(:call).once.and_yield
      subject
    end

    it 'adds nr tracing header' do
      expect(nr_tracer).to receive(:create_distributed_trace_payload).once.and_return(nr_trace_instance)
      subject
      expect(request_context.metadata[Gruf::Newrelic::NEWRELIC_TRACE_HEADER]).to eq(nr_header_data)
    end

    context "no header" do
      it 'skips nr tracing header' do
        expect(nr_tracer).to receive(:create_distributed_trace_payload).once.and_return(nil)
        subject
        expect(request_context.metadata[Gruf::Newrelic::NEWRELIC_TRACE_HEADER]).to eq(nil)
      end
    end
  end
end
