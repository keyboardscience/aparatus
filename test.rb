require 'zookeeper'

ZOOKEEPER_HOSTS = "192.168.31.254:31001"
ZOOKEEPER_PATH = "/kairos/production"

class ZookeeperTesting
  def initialize
    @zk = Zookeeper.new(ZOOKEEPER_HOSTS)
  
    raise Zookeeper::Exceptions::ContinuationTimeoutError unless @zk.connected?
    load!(ZOOKEEPER_PATH)
  end
  
  def load!(path)
    path_children = @zk.get_children(:path => path)[:children]
    p "path: " + path + " --- " + path_children.to_s
    unless path_children.empty?
      path_children.each { |child_path| load!(path+child_path) }
    end
    puts @zk.get(:path => path)
  end
end

ZookeeperTesting.new
