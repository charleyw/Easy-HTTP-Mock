#!/usr/bin/env ruby

require 'yaml'
require 'sinatra'

class EasyHTTPMock < Sinatra::Base
  set(:query) do |query_params|
    condition do
      query_params.detect do |key, value|
        (!params.has_key? key) || params[key] != value
      end.nil? ? true : false
    end
  end

  class << self
    def start(config, options)
      @mocking_config_file = config
      config_sinatra(options)
      begin
        define_mock(parsing_configuration(config))
      rescue Exception => e
        abort "Got exception when define mocked http service:\n#{e}"
      end
      run!
    end

    def config_sinatra(options)
      [:port, :addr].each { |key| set key, options[key] if options.key? key }
    end

    def parsing_configuration(config_file)
      settings = YAML.load_file config_file
      settings.sort do |x, y|
        x['request'].size < y['request'].size ? 1 : -1
      end

    end

    def define_mock(conf)
      conf.each do |service|
        requestConf, responseConf = service['request'], service['response']
        base_path = File.dirname(@mocking_config_file)
        get requestConf.delete('path'), requestConf.inject({}) { |h, (k, v)| h[k] = [v]; h} do
          File.read(base_path + '/' + responseConf)
        end
      end
    end

  end
end
