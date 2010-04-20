# This file is part of RDF-Inference
# 
# This is free software: you can redistribute it and/or modify
# it under the terms of the MIT License.
#
# This software is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# MIT License for more details.
#
#
# * Authors: Pius Uzamere
#

require 'pathname'
require 'lib/pomegranate'


require Pathname(__FILE__).dirname.expand_path.parent + 'spec_helper'
include Ruleby

describe "owl:FunctionalProperty", 'rule' do
  
  before(:all) do
    @e = engine :engine do |e|
      RdfsPlusRulebook.new(e).rules 

      p = RDF::Statement.new("mit:had_academic_advisor", "rdf:type", "owl:FunctionalProperty");
      h = RDF::Statement.new(":Pius", "mit:had_academic_advisor", ":Hal");
      d = RDF::Statement.new(":Pius", "mit:had_academic_advisor", ":Dude_Who_Wrote_SICP_With_Gerald_Sussman");
      e.assert p; e.assert h; e.assert d;
      e.match
    end
  end
  
  it "should be able to deduce sameness" do
    fact = RDF::Statement.new(":Hal", "owl:sameAs", ":Dude_Who_Wrote_SICP_With_Gerald_Sussman");
    f = @e.facts.select {|t| t.subject == ":Hal"}
    f.should include(fact)
  end
end