class XTF::Search::Element::Exact < XTF::Search::Element::Phrase

  def initialize(*args)
    super
    @tag_name = "exact"
  end

end
