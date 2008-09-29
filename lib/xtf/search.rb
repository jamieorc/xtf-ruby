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

module XTF
  module Search
    class Constants
      def self.phrase_delimiters
        /[\-\s\\\/.,;:()]+/
      end
    end
  end
end
$:.unshift(File.dirname(__FILE__))
require 'search/element'
