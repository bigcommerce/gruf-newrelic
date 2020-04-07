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

describe Gruf::Newrelic::ServerInterceptor do
  let(:service) { ThingService.new }
  let(:options) { {} }
  let(:signature) { 'get_thing' }
  let(:active_call) { grpc_active_call }
  let(:grpc_method_name) { 'ThingService.get_thing' }
  let(:request) do
    double(
      :request,
      method_key: signature,
      service: ThingService,
      rpc_desc: nil,
      active_call: active_call,
      request_class: ThingRequest,
      service_key: 'thing_service.thing_request',
      message: grpc_request,
      method_name: grpc_method_name
    )
  end
  let(:errors) { Gruf::Error.new }
  let(:interceptor) { described_class.new(request, errors, options) }

  describe '.call' do
    subject { interceptor.call { true } }

    it 'should trace the request' do
      expect(interceptor).to receive(:perform_action_with_newrelic_trace).with(
        category: Gruf::Newrelic.server_category,
        class_name: request.service.name,
        name: request.method_key
      ).once.and_yield
      subject
    end

    it 'should set metric grouping' do
      allow(Gruf::Newrelic).to receive(:transaction_name_prefixes).and_return(["Controller", "gRPC"])
      expect(interceptor).to receive(:perform_action_with_newrelic_trace).with(
        category: Gruf::Newrelic.server_category,
        class_name: 'Controller/gRPC/ThingService',
        name: 'get_thing'
      ).once.and_yield
      subject
    end

    context "distributed tracing" do
      let(:nr_tracer) { ::NewRelic::Agent::DistributedTracing }
      let(:nr_header_data) { 'newrelic-header-data' }
      let(:metadata) { { Gruf::Newrelic::NEWRELIC_TRACE_HEADER => nr_header_data } }
      let(:grpc_active_call) { double(:grpc_active_call, metadata: metadata, output_metadata: {}) }

      it 'should accept nr tracing payload within newrelic trace' do
        expect(interceptor).to receive(:perform_action_with_newrelic_trace).once.ordered.and_yield
        expect(nr_tracer).to receive(:accept_distributed_trace_payload).with(nr_header_data).once.ordered
        subject
      end
    end
  end
end
