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
require 'rdf'

require Pathname(__FILE__).dirname.expand_path.parent + 'spec_helper'
include Ruleby

describe "owl:equivalentClass", 'rule' do
  
  before(:all) do
    @e = engine :engine do |e|
      RdfsPlusRulebook.new(e).rules 

      p = RDF::Statement.new("mit:class", "owl:equivalentClass", "mit:subject"); 
      h = RDF::Statement.new(":6.170", "rdf:type", "mit:class");
      e.assert p
      e.assert h
      e.match
    end
  end
  
  it "should understand class equivalence when a RDF::Statement object is owl:equivalentClass another resource" do
    fact = RDF::Statement.new(":6.170", "rdf:type", "mit:subject");
    f = @e.facts.select {|t| t.subject == ":6.170"}
    f.should include(fact)
  end
end