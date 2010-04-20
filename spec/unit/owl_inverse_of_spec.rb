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

describe "owl:inverseOf", 'rule' do
  
  before(:all) do
    @e = engine :engine do |e|
      RdfsPlusRulebook.new(e).rules 
      
      alpha = RDF::Statement.new(":Pius", ":took_a_class_taught_by", ":Winston")
      beta = RDF::Statement.new(":took_a_class_taught_by", "owl:inverseOf", ":taught")

      e.assert alpha
      e.assert beta
      e.match
    end
  end
  
  it "should understand individual equivalence when a RDF::Statement object is owl:sameAs another resource" do
    fact = RDF::Statement.new(":Winston", ":taught", ":Pius");
    f = @e.facts.select {|t| t.subject == ":Winston"}
    f.should include(fact)
  end
end