class XTF::Search::Element::Or < XTF::Search::Element::Clause
  attribute_keys BASE_ATTRIBUTE_KEYS, :fields, :slop

  def initialize(*args)
    @tag_name = "or"
    params = args[0] || {}
    raise ArgumentError, "Provide :field or :fields, but not both" if params.key?(:field) && params.key?(:fields)
    raise ArgumentError, ":fields requires :slop" if params.key?(:fields) && !params.key?(:slop)
    raise ArgumentError, ":slop requires :fields" if params.key?(:slop) && !params.key?(:fields)
    super
  end

end
