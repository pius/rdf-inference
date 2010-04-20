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

describe "rdfs:subclassOf", 'rule' do
  
  before(:all) do
    @e = engine :engine do |e|
      RdfsPlusRulebook.new(e).rules 

      p = RDF::Statement.new(":Pius", "rdf:type", ":male")
      h = RDF::Statement.new(":male", "rdfs:subClassOf", ":human") 
      e.assert p
      e.assert h
      e.match
    end
  end
  
  it "should understand individual equivalence when a RDF::Statement object is rdfs:subClassOf another resource" do
    fact = RDF::Statement.new(":Pius", "rdf:type", ":human")
    @e.match
    f = @e.facts.select {|t| t.subject == ":Pius"}
    @e.facts.should include(fact)
  end
end
