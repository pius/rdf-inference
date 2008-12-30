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

describe "owl:SymmetricProperty", 'rule' do
  
  before(:all) do
    @e = engine :engine do |e|
      RdfsPlusRulebook.new(e).rules 
      
      eta = Triple.new(":Pius", ":was_in_a_class_with", ":Adam"); 
      zeta = Triple.new(":was_in_a_class_with", "rdf:type", "owl:SymmetricProperty")

      e.assert zeta
      e.assert eta
      e.match
    end
  end
  
  it "should understand individual equivalence when a triple object is owl:sameAs another resource" do
    fact = Triple.new(":Adam", ":was_in_a_class_with", ":Pius");
    f = @e.facts.select {|t| t.subject == ":Adam"}
    f.should include(fact)
  end
end