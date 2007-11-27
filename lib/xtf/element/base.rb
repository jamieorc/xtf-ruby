class XTF::Element::Base
  
  attr_accessor :attributes
  attr_accessor :section_type #available on all elements except <not>
  
  def initialize(*args)
    @attributes = {}
    params = args[0] || {}
    params = params.symbolize_keys
    @attributes.merge!(params)
  end

end