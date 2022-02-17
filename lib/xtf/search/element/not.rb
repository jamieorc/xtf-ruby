class XTF::Search::Element::Not < XTF::Search::Element::Clause
  def initialize(*args)
    @tag_name = "not"
    super
  end

end
