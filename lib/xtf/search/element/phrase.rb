class XTF::Search::Element::Phrase < XTF::Search::Element::Clause
  # Takes a +String+ and breaks it up into +Term+s:
  attr_accessor :phrase

  def initialize(*args)
    @tag_name = "phrase"
    params = args[0] || {}
    _phrase = params.delete(:phrase)
    super(params)
    self.phrase = _phrase if _phrase
  end

  # If the last term is a wildcard, then append it to the previous term.
  def phrase=(terms)
    raise ArgumentError unless terms.is_a?(String)
    terms = terms.split(XTF::Search::Constants.phrase_delimiters)
    terms.first.gsub!(/^"/, "")
    terms.shift if terms.first == ""
    terms.last.gsub!(/"$/,"")
    terms.pop if terms.last == ""
    if terms.last == "*"
      terms.pop
      terms.last << "*"
    end
    terms.each { |t| self.content << XTF::Search::Element::Term.new(t) }
  end

end
