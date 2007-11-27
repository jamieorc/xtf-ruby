class XTF::Element::Clause < XTF::Element::Base
  
  # an Array that contains any number of clauses and/or terms
  attr_accessor :content, :tag_name
  
  def initialize(*args)
    @tag_name = args.shift.to_s if args[0].is_a?(String) or args[0].is_a?(Symbol)
    super
    tn = @attributes.delete(:tag_name)
    @tag_name ||= tn
    (raise ArgumentError, "need tag_name for XTF::Element::Clause") unless @tag_name
    @content = @attributes.delete(:content) || []
    @content = [@content] unless @content.is_a?(Array)
  end
  
end