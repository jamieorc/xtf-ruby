class XTF::Element::Exact < XTF::Element::Clause

  def initialize(*args)
    @tag_name = "exact"
    super
  end
  
end