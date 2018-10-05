# coding: utf-8
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

class TestConfiguration
  include Gruf::Newrelic::Configuration
end

describe Gruf::Newrelic::Configuration do
  let(:obj) { TestConfiguration.new }

  describe '.reset' do
    subject { obj.server_category }

    it 'should reset config vars to default' do
      obj.configure do |c|
        c.server_category = :request
      end
      obj.reset
      expect(subject).to_not eq :request
    end
  end

  describe '.environment' do
    subject { obj.send(:environment) }

    context 'ENV RAILS_ENV' do
      before do
        allow(ENV).to receive(:[]).with('RACK_ENV').and_return nil
        allow(ENV).to receive(:[]).with('RAILS_ENV').and_return 'production'
      end
      it 'should return the proper environment' do
        expect(subject).to eq 'production'
      end
    end

    context 'ENV RACK_ENV' do
      before do
        allow(ENV).to receive(:[]).with('RACK_ENV').and_return 'production'
        allow(ENV).to receive(:[]).with('RAILS_ENV').and_return nil
      end
      it 'should return the proper environment' do
        expect(subject).to eq 'production'
      end
    end
  end

  describe '.options' do
    subject { obj.options }
    before do
      obj.reset
    end

    it 'should return the options hash' do
      expect(obj.options).to be_a(Hash)
      expect(obj.options[:server_category]).to eq :controller
    end
  end
end
