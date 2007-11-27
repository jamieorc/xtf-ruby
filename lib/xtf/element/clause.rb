class XTF::Element::Clause < XTF::Element::Base
  
  # an Array that contains any number of clauses and/or terms
  attr_accessor :contents
  
  def initialize(*args)
    super
    params = args[0] || {}
    @contents = params.symbolize_keys()[:contents] || []
  end
  
end