# Extends +Near+, as they are identical except for +tag_name+
class XTF::Search::Element::OrNear < XTF::Search::Element::Near
  attribute_keys BASE_ATTRIBUTE_KEYS, :slop

  # +slop+ is required. You can pass it in as the first argument or in the attributes +Hash+
  # with the key +:slop+.
  def initialize(*args)
    @tag_name = "orNear"
    super
  end
end
