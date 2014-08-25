#!/usr/bin/env ruby

Dir[File.join(File.expand_path(File.dirname(__FILE__)), "../lib/*.rb")].map { |file| require file }