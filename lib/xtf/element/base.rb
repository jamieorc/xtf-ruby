class XTF::Element::Base
  
  attr_accessor :attributes
  attr_reader :tag_name
  
  def initialize(*args)
    @attributes = {}
    params = args[0] || {}
    params = params.symbolize_keys
    @attributes.merge!(params)
  end

end