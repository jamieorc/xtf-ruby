class XTF::Element::Clause < XTF::Element::Base
  
  # an Array that contains any number of clauses and/or terms
  attr_accessor :content
  
  def initialize(*args)
    super
    params = args[0] || {}
    @content = params.symbolize_keys()[:content] || []
  end
  
end