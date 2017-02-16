require 'pry'
require 'faraday'

response = Faraday.get 'http://127.0.0.1:9090'
binding.pry
p response.env
