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
      [:port, :addr].each {|key| set key, options[key] if options.key? key}
      begin
        define_mock(parsing_configuration(config))
      rescue Exception => e
        puts 'Got exception when define mock http service'
        puts e
      end
      run!
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
        get requestConf.delete('path'), requestConf.inject({}) { |h, (k, v)| h[k] = [v]; h} do
          File.read(File.dirname(__FILE__) + "/" + responseConf)
        end
      end
    end

  end
end
