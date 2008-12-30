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

describe "owl:InverseFunctionalProperty", 'rule' do
  
  before(:all) do
    @e = engine :engine do |e|
      RdfsPlusRulebook.new(e).rules 

      p = Triple.new("mit:lived_alone_fall_2004_in", "rdf:type", "owl:InverseFunctionalProperty");
      h = Triple.new(":Pius", "mit:lived_alone_fall_2004_in", ":pomegranate_314_at_Next_House");
      d = Triple.new(":2004_UA_President", "mit:lived_alone_fall_2004_in", ":pomegranate_314_at_Next_House");
      e.assert p; e.assert h; e.assert d;
      e.match
    end
  end
  
  it "should be able to deduce sameness" do
    fact = Triple.new(":2004_UA_President", "owl:sameAs", ":Pius");
    f = @e.facts.select {|t| t.subject == ":2004_UA_President"}
    f.should include(fact)
  end
end