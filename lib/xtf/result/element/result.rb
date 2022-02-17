class XTF::Result::Element::Result
#   require 'rubygems'
#   require 'libxml_helper'
  DEFAULT_DOCS_PER_PAGE = 50
  attr_reader :tag_name,
              :xml,
              :doc,
              :search,
              :query,
              :query_time,
              :total_docs,
              :start_doc,
              :end_doc,
              :doc_hits,
              :docs_per_page,
              :facets
  alias :hits :doc_hits

  def initialize(xml=nil, search=nil)
    start = Time.now
    @tag_name = "crossQueryResult"
    @doc_hits = []
    @facets = []
    parse_xml(xml) if xml
    @search = search
#     RAILS_DEFAULT_LOGGER.debug("~~~~~ #{self.class.name} initialized #{@doc_hits.size} hits and #{@facets.size} facets in #{Time.now - start} seconds.")
  end

  # Parses the important bits out of the XTF search results using LibXML-Ruby.
  def parse_xml(xml)
    @xml = xml.to_s.gsub(/\s+/, " ").strip
    @doc = XML::Document.parse_string(@xml).root

    # the query metadata
    @query_time = @doc.at('/crossQueryResult')['queryTime']
    @total_docs = @doc.at('/crossQueryResult')['totalDocs']
    @start_doc = @doc.at('/crossQueryResult')['startDoc']
    @end_doc = @doc.at('/crossQueryResult')['endDoc']
    @docs_per_page = @doc.at("/crossQueryResult/query")['maxDocs'] rescue DEFAULT_DOCS_PER_PAGE

    @query = @doc.at('/crossQueryResult/query').to_s
    # the docHits
    # TODO deal with PDFS. This currently filters them from the results
    @doc_hits = @doc.search('./docHit').collect { |h| XTF::Result::Element::DocHit.create(h, @query) }.compact

    @facets = @doc.search('/crossQueryResult/facet').collect { |f| XTF::Result::Element::Facet.new(f, @query) }
  end

  def empty?
    self.hits.size < 1
  end

  def previous_start_doc
    diff = start_doc.to_i - docs_per_page.to_i
    diff < 1 ? "1" : diff.to_s
  end
  alias :prev_start_doc :previous_start_doc

  def next_start_doc
    sum = start_doc.to_i + docs_per_page.to_i
    sum > total_docs.to_i ? start_doc : sum.to_s
  end

  def last_start_doc
    (((total_docs.to_i-1) / docs_per_page.to_i) * docs_per_page.to_i + 1).to_s
  end

  def total_pages
    (((total_docs.to_i-1) / docs_per_page.to_i) + 1).to_s
  end

  def current_page
    (((start_doc.to_i-1) / docs_per_page.to_i) + 1).to_s
  end

  def start_doc_for_page(page)
    return "1" if page.to_i <= 1
    return self.last_start_doc if page.to_i >= self.total_pages.to_i
    (docs_per_page.to_i * (page.to_i - 1) + 1).to_s
  end

  def next_page_query_string()
    "startDoc=#{self.next_start_doc}&docsPerPage=#{self.docs_per_page}"
  end

  def previous_page_query_string()
    "startDoc=#{self.previous_start_doc}&docsPerPage=#{self.docs_per_page}"
  end
  alias :prev_page_query_string :previous_page_query_string

end
