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

describe "rdfs:domain", 'rule' do
  
  before(:all) do
    @e = engine :engine do |e|
      RdfsPlusRulebook.new(e).rules 
      
      a = RDF::Statement.new("mit:majored_in", "rdfs:domain", ":student"); 
      b = RDF::Statement.new(":Pius", "mit:majored_in", ":Course_17")

      e.assert a
      e.assert b
      e.match
    end
  end
  
  it "should understand domains" do
    fact = RDF::Statement.new(":Pius", "rdf:type", ":student")
    f = @e.facts.select {|t| t.subject == ":Pius"}
    f.should include(fact)
  end
end