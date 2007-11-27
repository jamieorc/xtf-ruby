class XTF::Element::Term < XTF::Element::Base
  attr_accessor :value
  def initialize(*args)
    super
    @value = nil
    @value = @attributes.delete(:value)
  end
end