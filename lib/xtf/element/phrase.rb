class XTF::Element::Phrase < XTF::Element::Clause

  def initialize(*args)
    @tag_name = "phrase"
    super
  end
  
end