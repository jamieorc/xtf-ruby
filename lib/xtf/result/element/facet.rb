class XTF::Result::Element::Facet
#   require 'rubygems'
#   require 'libxml_helper'
  attr_reader :query,
              :field,
              :total_groups,
              :total_docs,
              :groups

  def initialize(xml=nil, search=nil)
    start = Time.now
    @groups = []
    @query = query
    parse_xml(xml) if xml
#     RAILS_DEFAULT_LOGGER.debug("~~~~~ #{self.class.name} initialized #{@groups.size} hits in #{Time.now - start} seconds.")
  end

  # Parses the important bits out of the XTF search results using LibXML-Ruby.
  def parse_xml(xml)
    @xml = xml.to_s.squish #.gsub(/\s+/, " ").strip
    @doc = XML::Document.parse_string(@xml).root
    # the query metadata
    @field = @doc.at('/facet')['field']
    @total_groups = @doc.at('/facet')['totalGroups']
    @total_docs = @doc.at('/facet')['totalDocs']

    @groups = @doc.search('/facet/group').collect { |h| XTF::Result::Element::Group.new(h, @query) }.compact
  end
end
