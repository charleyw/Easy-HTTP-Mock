Easy Http mock
================

The goal of this project is to provide a simple way to mock http request and response for specific condition.

## How to use

1. Install 

		gem install easy-http-mock
		
1. Create a yaml file to config the mocked services, 

	
	```
	#settings.yml
	---
	  - 
    	request: 
	      	path: /bar
    	response: bar.json
	  -
    	request:
	      path: /bar
    	  query:
        	param_one: haha
	        param_two: blabla
    	response: bar_haha.json
	...
	```
1. Start mocking server

		ehm settings.yml

1. Test the results

		curl http://localhost:4567/bar
		
	You will get the text that specified in bar.json. As we have defined in the settings.yml, when visit `/bar`, it will return the bar.json file.
	
		curl http://localhost:4567/bar?param_one=haha&param_two=blabla
	
	You will get the text that defined in bar_haha.json. So the second route definition will only be return when you request it with specified params with the correct value.

		curl http://localhost:4567/bar?param_one=not_correct_value
		
	This one will return the bar.json, since if any of the conditional definitions(The second one) are not satified, then the default one(The first one in this example) will be returned.
	
## Advance Usages with yaml syntax

Create your settings file with yaml node anchor and reference
```
---
  - &bar
    request: &bar_request
      path: /bar
    response: bar.json
  -
    request:
      <<: *bar_request
      query:
        param_one: haha
        param_two: blabla
    response: bar_haha.json
  -
    request:
      <<: *bar_request
      query:
        param_three: hehe
    response: bar_hehe.json
...
```
With this, you can reuse other mock service defination. For example, all the three service in the settings.yml using same path, so we can use yaml anchor and reference to reduce the redundant settings.

## Setting the server

Using following command to show help information, you can config the port and bind address for the server.

	ehm -h
	
## Future work

Other http verb, for example **POST**, **PUT** and **DELETE** will be added.

## Liscense
© 2014 Wang Chao. This code is distributed under the MIT license.