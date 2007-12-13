class XTF::Element::Near < XTF::Element::Clause
  attribute_keys BASE_ATTRIBUTE_KEYS, :slop
  
  # +slop+ is required. You can pass it in as the first argument or in the attributes +Hash+
  # with the key +:slop+. 
  def initialize(*args)
    @tag_name = "near"
    @slop = args.shift.to_s if args[0].is_a?(String) || args[0].is_a?(Integer)
    params = args[0] || {}
    raise ArgumentError, "supply slop as first argument or as attribute of Hash, but not both!" if @slop && params.key?(:slop)
    
    @slop = params.delete(:slop) unless @slop
    raise ArgumentError, "slop is required." unless @slop
    
    super
  end
end