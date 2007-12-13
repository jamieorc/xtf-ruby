module XTF
  module Element
  end
end

require File.dirname(__FILE__) + "/element/base.rb"
require File.dirname(__FILE__) + "/element/clause.rb"

Dir[File.dirname(__FILE__) + "/element/*.rb"].each { |file| require(file) }