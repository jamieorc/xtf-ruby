class XTF::Element::Or < XTF::Element::Clause
  def initialize(*args)
    @tag_name = "or"
    super
  end
end