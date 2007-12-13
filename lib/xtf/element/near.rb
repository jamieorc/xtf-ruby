class XTF::Element::Near < XTF::Element::Clause
  def initialize(*args)
    @tag_name = "near"
    super
  end
  
end