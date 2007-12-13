class XTF::Element::Not < XTF::Element::Clause
  def initialize(*args)
    @tag_name = "not"
    super
  end
  
end