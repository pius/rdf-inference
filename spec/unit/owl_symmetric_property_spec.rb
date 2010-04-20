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

describe "owl:SymmetricProperty", 'rule' do
  
  before(:all) do
    @e = engine :engine do |e|
      RdfsPlusRulebook.new(e).rules 
      
      eta = RDF::Statement.new(":Pius", ":was_in_a_class_with", ":Adam"); 
      zeta = RDF::Statement.new(":was_in_a_class_with", "rdf:type", "owl:SymmetricProperty")

      e.assert zeta
      e.assert eta
      e.match
    end
  end
  
  it "should understand individual equivalence when a RDF::Statement object is owl:sameAs another resource" do
    fact = RDF::Statement.new(":Adam", ":was_in_a_class_with", ":Pius");
    f = @e.facts.select {|t| t.subject == ":Adam"}
    f.should include(fact)
  end
end