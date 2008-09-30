# Copyright 2008 James (Jamie) Orchard-Hays
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#   http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class XTF::Result::Element::Group
#   require 'rubygems'
#   require 'libxml_helper'
  attr_reader :query,
              :value, 
              :total_sub_groups,
              :total_docs,
              :start_doc,
              :end_doc,
              :doc_hits

  alias :hits :doc_hits
  
  def initialize(xml=nil, query="")
    start = Time.now
    @doc_hits = []
    @query = query
    parse_xml(xml) if xml
#     RAILS_DEFAULT_LOGGER.debug("~~~~~ #{self.class.name} initialized #{@doc_hits.size} hits in #{Time.now - start} seconds.")
  end

  # Parses the important bits out of the XTF search results using LibXML-Ruby.
  def parse_xml(xml)
    @xml = xml.to_s.squish #.gsub(/\s+/, " ").strip
    @doc = XML::Document.parse_string(@xml).root

    @value = @doc.at('/group')['value']
    @total_sub_groups = @doc.at('/group')['totalSubGroups']
    @total_docs = @doc.at('/group')['totalDocs']
    @start_doc = @doc.at('/group')['startDoc']
    @end_doc = @doc.at('/group')['endDoc']
    
    ## TODO subgroups
    @doc_hits = @doc.search('/group/docHit').collect { |h| XTF::Result::Element::DocHit.create(h, @query) }.compact
  end
  
end