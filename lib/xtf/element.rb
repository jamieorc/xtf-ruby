module XTF
  module Element
  end
end

Dir[File.dirname(__FILE__) + "/element/*.rb"].each { |file| require(file) }