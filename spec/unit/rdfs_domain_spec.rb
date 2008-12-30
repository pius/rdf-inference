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
require 'lib/pomegranate'


require Pathname(__FILE__).dirname.expand_path.parent + 'spec_helper'
include Ruleby

describe "rdfs:domain", 'rule' do
  
  before(:all) do
    @e = engine :engine do |e|
      RdfsPlusRulebook.new(e).rules 
      
      a = Triple.new("mit:majored_in", "rdfs:domain", ":student"); 
      b = Triple.new(":Pius", "mit:majored_in", ":Course_17")

      e.assert a
      e.assert b
      e.match
    end
  end
  
  it "should understand domains" do
    fact = Triple.new(":Pius", "rdf:type", ":student")
    f = @e.facts.select {|t| t.subject == ":Pius"}
    f.should include(fact)
  end
end