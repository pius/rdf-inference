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
      
      p = RDF::Statement.new(":Dirichlet", ":is_an_academic_ancestor_of", ":Minsky"); 
      h = RDF::Statement.new(":Poisson", ":is_an_academic_ancestor_of", ":Dirichlet");
      j = RDF::Statement.new(":is_an_academic_ancestor_of", "rdf:type", "owl:TransitiveProperty");

      e.assert p
      e.assert h
      e.assert j
      e.match
    end
  end
  
  it "should understand transitivity when a property is an owl:TransitiveProperty" do
    fact = RDF::Statement.new(":Poisson", ":is_an_academic_ancestor_of", ":Minsky");
    f = @e.facts.select {|t| t.subject == ":Poisson"}
    f.should include(fact)
  end
end