require 'yaml'
require 'zookeeper'

module Aparatus
  def self.config
    @@_config ||= ActiveSupport::OrderedOptions.new
  end

  class Railtie < Rails::Railtie
    initializer "aparatus_railtie.load_config" do |_|
      ConfigLoader.new
    end
  end

  class ConfigLoader
    class NoConfigFound < StandardError
    end

    class CannotConnect < Zookeeper::Exceptions::ContinuationTimeoutError
    end

    def initialize(env = nil)
      zk = Zookeeper.new(ZOOKEEPER_HOSTS)
      raise CannotConnect unless zk.connected?
      load!(ZOOKEEPER_PATH)
    end

    def load!(path)
      unless zk.get_children(:path => path)[:children].length > 0
        
      end
    end
  end
end
