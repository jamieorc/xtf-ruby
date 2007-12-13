class XTF::Element::OrNear < XTF::Element::Clause
  def initialize(*args)
    @tag_name = "orNear"
    super
  end
  
end