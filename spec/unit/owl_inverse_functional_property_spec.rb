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

describe "owl:InverseFunctionalProperty", 'rule' do
  
  before(:all) do
    @e = engine :engine do |e|
      RdfsPlusRulebook.new(e).rules 

      p = RDF::Statement.new("mit:lived_alone_fall_2004_in", "rdf:type", "owl:InverseFunctionalProperty");
      h = RDF::Statement.new(":Pius", "mit:lived_alone_fall_2004_in", ":pomegranate_314_at_Next_House");
      d = RDF::Statement.new(":2004_UA_President", "mit:lived_alone_fall_2004_in", ":pomegranate_314_at_Next_House");
      e.assert p; e.assert h; e.assert d;
      e.match
    end
  end
  
  it "should be able to deduce sameness" do
    fact = RDF::Statement.new(":2004_UA_President", "owl:sameAs", ":Pius");
    f = @e.facts.select {|t| t.subject == ":2004_UA_President"}
    f.should include(fact)
  end
end