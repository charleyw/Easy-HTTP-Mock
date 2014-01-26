require 'yaml'
require 'sinatra'

set(:query) do |query_params|
  condition do
    query_params.detect do |key, value|
      (!params.has_key? key) || params[key] != value
    end.nil? ? true : false
  end
end

settings = YAML.load_file "./test.yml"

def process_configuration conf
  conf.sort do |x, y|
    x['request'].size < y['request'].size ? 1 : -1
  end
end

process_configuration(settings).each do |service|
  requestConf, responseConf = service['request'], service['response']
  get requestConf.delete('path'), requestConf do
    File.read(File.dirname(__FILE__) + "/" + responseConf)
  end
end
