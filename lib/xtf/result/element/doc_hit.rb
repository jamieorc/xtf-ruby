class XTF::Result::Element::DocHit

#   require 'rubygems'
#   require 'libxml_helper'
#   require 'erb'
#   include ERB::Util
#   include ExportableDocument

  attr_reader :xml,
              :doc,
              :rank,
              :path,
              :raw_path,
              :score,
              :total_hits,
              :query,
              :snippets,
              :raw_snippets


  # Converts +maxSnippets+ to a value of -1 (all), so that proper hit counts are shown
  # in the XTF-rendered document. An instance variable is lazily loaded.
  def query_with_all_snippets
    self.query.gsub(/maxSnippets=("|')\d+("|')/, %Q{maxSnippets="-1"})
  end

  def initialize(xml, query_params="")
    start = Time.now
    parse_xml(xml, query_params)
    yield self if block_given?
#     RAILS_DEFAULT_LOGGER.debug("~~~~~ #{self.class.name} initialized in #{Time.now - start} seconds.")
  end

  def self.create(xml, query_params="")
    new(xml.to_s, query_params)
  end

  def parse_xml(xml, query)
    @xml = xml.to_s.gsub(/\s+/, " ").strip
    @query = query
    @doc = XML::Document.parse_string(xml).root
    doc_hit = @doc.at('//docHit')
#     meta = doc_hit.at('//meta')

    @rank = doc_hit['rank']
    @path = @raw_path = doc_hit['path']

    @score = doc_hit['score']

    # only retrieves the non-meta snippets
    @snippets = @raw_snippets = @doc.search('//docHit/snippet').collect { |s| s.to_s }

    # NOTE if there are totalHits, then use them, else use meta_hit_count. XTF gives a count for all hits when
    # there are totalHits, but none at all when only metadata hits.
    # NOTE some of the XTF devs argued against counting Meta Data Hits.
#     @meta_hit_count = doc_hit.search('//meta//hit').size rescue 0
#     @total_hits = doc_hit['totalHits'].to_i > 0 ? doc_hit['totalHits'] : @meta_hit_count.to_s
    @total_hits = doc_hit['totalHits']
  end

end
