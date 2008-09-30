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

class XTF::Result::Element::Base
  
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
              :query
              
    
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
    meta = doc_hit.at('//meta')
    
    @rank = doc_hit['rank']
    @path = @raw_path = doc_hit['path']
    
    @score = doc_hit['score']

    # NOTE if there are totalHits, then use them, else use meta_hit_count. XTF gives a count for all hits when
    # there are totalHits, but none at all when only metadata hits.
    @meta_hit_count = doc_hit.search('//meta//hit').size rescue 0
    @total_hits = doc_hit['totalHits'].to_i > 0 ? doc_hit['totalHits'] : @meta_hit_count.to_s
  end
    
end