# This file is part of Pomegranate
# 
# Pomegranate is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# Pomegranate is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
# 
# You should have received a copy of the GNU Lesser General Public License
# along with Pomegranate.  If not, see <http://www.gnu.org/licenses/>.

require 'pathname'
#require 'ruleby'
require 'lib/pomegranate'
# require 'lib/pomegranate/rdfs_rulebook'
# require 'lib/pomegranate/rdfsplus_rulebook'

require Pathname(__FILE__).dirname.expand_path.parent + 'spec_helper'
include Ruleby

describe "rdfs:subPropertyOf", 'rule' do
  
  before(:all) do
    @e = engine :engine do |e|
      RdfsPlusRulebook.new(e).rules 
      
      q = Triple.new(":Pius", "mit:majored_in", ":Course_6"); 
      r = Triple.new("mit:majored_in", "rdfs:subPropertyOf", "mit:took_some_classes_in")

      e.assert q
      e.assert r
      e.match
    end
  end
  
  it "should understand subproperties when a resource is rdfs:subPropertyOf another resource" do
    fact = Triple.new(":Pius", "mit:took_some_classes_in", ":Course_6");
    @e.match
    f = @e.facts.select {|t| t.subject == ":Pius"}
    @e.facts.should include(fact)
  end
end