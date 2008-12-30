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

describe "owl:TransitiveProperty", 'rule' do
  
  before(:all) do
    @e = engine :engine do |e|
      RdfsPlusRulebook.new(e).rules 
      
      p = Triple.new(":Dirichlet", ":is_an_academic_ancestor_of", ":Minsky"); 
      h = Triple.new(":Poisson", ":is_an_academic_ancestor_of", ":Dirichlet");
      j = Triple.new(":is_an_academic_ancestor_of", "rdf:type", "owl:TransitiveProperty");

      e.assert p
      e.assert h
      e.assert j
      e.match
    end
  end
  
  it "should understand transitivity when a property is an owl:TransitiveProperty" do
    fact = Triple.new(":Poisson", ":is_an_academic_ancestor_of", ":Minsky");
    f = @e.facts.select {|t| t.subject == ":Poisson"}
    f.should include(fact)
  end
end