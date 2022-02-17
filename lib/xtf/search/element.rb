module XTF
  module Search
    module Element
    end
  end
end

$:.unshift(File.dirname(__FILE__))
require 'element/base'
require 'element/section_type'
require 'element/result_data'
require 'element/clause'
require 'element/near'
require 'element/phrase'
Dir[File.dirname(__FILE__) + "/element/*.rb"].each { |file| require(file) }
