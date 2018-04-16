require 'ripple/error'
require 'ripple/configuration'
require 'ripple/api'
require 'ripple/models/path'
require 'ripple/models/amount'
require 'ripple/models/transaction'
require 'ripple/models/account_info'
require 'ripple/models/account_lines'
require 'ripple/client'
require 'ripple/extensions/federation'
require 'ripple/abstract'
require 'ripple/request'
require 'ripple/response'

module Ripple; end

class << Ripple
  extend Configuration

  # Alias for Ripple::Client.new
  #
  # @return [Ripple::Client]
  def self.client(options={})
    Ripple::Abstract.new(options)
  end

  def self.federation #(method, *args, &block)
    Ripple::Federation.new #.send(method, *args, &block)
  end

  # Delegate to Ripple::Abstract
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  # Delegate to Ripple::Abstract
  def self.respond_to?(method)
    return client.respond_to?(method) || super
  end
end
