require 'rake'
require 'rubygems'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/packagetask'
require 'rake/gempackagetask'
require 'spec/rake/spectask'

XTF_RUBY_VERSION = "0.2.1"

desc "Run all specs by default"
task :default => :spec

desc "Run all specs"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/**/*.rb']
end

spec = Gem::Specification.new do |s|
  s.name = 'xtf-ruby'
  s.version = XTF_RUBY_VERSION
  s.author = 'James (Jamie) Orchard-Hays'
  s.email = 'jamieorc@dangosaur.us'
  s.homepage = 'http://xtf.rubyforge.org'
  s.platform = Gem::Platform::RUBY
  s.summary = "Ruby library for working with California Digital Library's XTF"
  
  # Omit functional tests from gem for now, as that requires a Solr instance
  s.files = Dir.glob("lib/**/*").concat(Dir.glob("spec/**/*"))
  s.require_path = 'lib'
  s.autorequire = 'xtf'
  s.has_rdoc = true
end

namespace :gem do
  Rake::GemPackageTask.new(spec) do |pkg|
    pkg.need_zip = true
    pkg.need_tar = true
    pkg.package_dir = "pkg/gem"
  end
end

namespace :rails do
  desc "Creates rails plugin structure and distributable packages. init.rb is created and removed on the fly."
  task :package => "init.rb" do
    FileUtils.rm_f("init.rb")
  end
  Rake::PackageTask.new("xtf-ruby-rails", XTF_RUBY_VERSION) do |pkg|
    pkg.need_zip = true
    pkg.need_tar = true
    pkg.package_dir = "pkg/rails"
    pkg.package_files.include("lib/**/*.rb", "spec/**/*.rb", "init.rb", "LICENSE.txt", "README", "NOTICE.txt")
  end
  
  file "init.rb" do
    open("init.rb", "w") do |file|
      file.puts LICENSE
      file.puts "require 'xtf.rb'"
    end
  end
  
  desc "Install the Rails plugin version into the vendor/plugins dir. Need to set PLUGINS_DIR environment variable."
  task :install => :package do
    plugins_dir = ENV["PLUGINS_DIR"] or raise "You must set PLUGINS_DIR"
    mkdir File.join(plugins_dir, "xtf-ruby-rails-#{XTF_RUBY_VERSION}/") rescue nil
    FileUtils.cp_r(File.join("pkg","rails", "xtf-ruby-rails-#{XTF_RUBY_VERSION}/"), plugins_dir)
  end
end

task :package => ["rails:package", "gem:package"]
task :repackage => [:clobber_package, :package]
task :clobber_package => ["rails:clobber_package", "gem:clobber_package"] do rm_r "pkg" rescue nil end
task :clobber => [:clobber_package]

desc "Generate rdoc documentation"
Rake::RDocTask.new('doc') do |rd|
  rd.rdoc_files.include("lib/**/*.rb")
  rd.rdoc_files.include('README', 'CHANGES.yml', 'LICENSE.txt')
  rd.main = 'README'
  rd.rdoc_dir = 'doc'
end


LICENSE = <<STR
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
STR
