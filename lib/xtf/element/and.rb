class XTF::Element::And < XTF::Element::Clause
  attribute_keys BASE_ATTRIBUTE_KEYS, :fields, :use_proximity, :slop
  
  def initialize(*args)
    @tag_name = "and"
    params = args[0] || {}
    raise ArgumentError, "Provide :field or :fields, but not both" if params.key?(:field) && params.key?(:fields)
    raise ArgumentError, ":fields requires :slop" if params.key?(:fields) && !params.key?(:slop)
    raise ArgumentError, ":slop requires :fields" if params.key?(:slop) && !params.key?(:fields)
    super
  end
    
end