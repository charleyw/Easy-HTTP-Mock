require 'yaml'
require 'sinatra'

set(:query) do |query_params|
  condition do
    query_params.detect do |key, value|
      (!params.has_key? key) || params[key] != value
    end.nil? ? true : false
  end
end

SETTINGS = YAML.load_file "./test.yml"

#SETTINGS.each do |service|
#  p "========================"
#  p service
#  p "========================"
#  requestConf, responseConf = service['request'], service['response']
#  get requestConf.delete('path'), requestConf do
#    File.read(File.dirname(__FILE__) + "/" + responseConf)
#  end
#end


get '/bar', :query => [{'param_one' => 'haha'}]  do
  File.read(File.dirname(__FILE__) + "/" + "bar_haha.json")
end

get '/bar', :query => [{'param_three' => 'hehe'}]  do
  File.read(File.dirname(__FILE__) + "/" + "bar_hehe.json")
end

get '/bar' do
  File.read(File.dirname(__FILE__) + "/" + "bar.json")
end
