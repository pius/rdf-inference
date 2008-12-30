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

describe "owl:sameAs", 'rule' do
  
  before(:all) do
    @e = engine :engine do |e|
      RdfsPlusRulebook.new(e).rules 
      p = Triple.new(":Pius", "mit:took_class_at", ":The_Media_Lab");
      h = Triple.new(":Pius", "owl:sameAs", ":Uzamere");
      d = Triple.new(":The_Media_Lab", "owl:sameAs", ":Media_Lab");
      e.assert h
      e.assert p
      e.assert d
      e.match
    end
  end
  
  it "should understand individual equivalence when a triple subject is owl:sameAs another resource" do
    fact = Triple.new(":Uzamere", "mit:took_class_at", ":The_Media_Lab");
    f = @e.facts.select {|t| t.subject == ":Uzamere"}
    f.should include(fact)
  end
  
  it "should understand individual equivalence when a triple object is owl:sameAs another resource" do
    fact = Triple.new(":Pius", "mit:took_class_at", ":Media_Lab");
    f = @e.facts.select {|t| t.subject == ":Pius"}
    f.should include(fact)
  end
end
