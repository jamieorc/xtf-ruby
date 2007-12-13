class XTF::Element::And < XTF::Element::Clause
  def initialize(*args)
    @tag_name = "and"
    super
  end
  
end