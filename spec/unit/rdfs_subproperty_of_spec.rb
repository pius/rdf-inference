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

describe "rdfs:subPropertyOf", 'rule' do
  
  before(:all) do
    @e = engine :engine do |e|
      RdfsPlusRulebook.new(e).rules 
      
      q = RDF::Statement.new(":Pius", "mit:majored_in", ":Course_6"); 
      r = RDF::Statement.new("mit:majored_in", "rdfs:subPropertyOf", "mit:took_some_classes_in")

      e.assert q
      e.assert r
      e.match
    end
  end
  
  it "should understand subproperties when a resource is rdfs:subPropertyOf another resource" do
    fact = RDF::Statement.new(":Pius", "mit:took_some_classes_in", ":Course_6");
    @e.match
    f = @e.facts.select {|t| t.subject == ":Pius"}
    @e.facts.should include(fact)
  end
end