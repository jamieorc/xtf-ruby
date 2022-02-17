module XTF
  module Result
    module Element
    end
  end
end
$:.unshift(File.dirname(__FILE__))
require 'element/base'
require 'element/doc_hit'
require 'element/group'
require 'element/facet'
require 'element/result'
#Dir[File.dirname(__FILE__) + "/element/*.rb"].each { |file| require(file) }
