# frozen_string_literal: true

require 'rspec'
require 'pry'
require 'json'
require 'faraday'
require 'securerandom'
require_relative 'api_client'
require_relative 'spec_support'


def logger
  logger = Logger.new File.new('example.log', 'a')
  logger.level = Logger::INFO  
  logger
end
