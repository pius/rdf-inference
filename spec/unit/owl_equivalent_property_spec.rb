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

describe "owl:equivalentProperty", 'rule' do
  
  before(:all) do
    @e = engine :engine do |e|
      RdfsPlusRulebook.new(e).rules 

      p = RDF::Statement.new("mit:took_class", "owl:equivalentProperty", "mit:took_course"); 
      h = RDF::Statement.new(":Pius", "mit:took_course", ":6.171");

      e.assert p
      e.assert h
      e.match
    end
  end
  
  it "should understand property equivalence when a property is owl:equivalentProperty to another" do
    fact = RDF::Statement.new(":Pius", "mit:took_class", ":6.171");
    f = @e.facts.select {|t| t.subject == ":Pius"}
    f.should include(fact)
  end
end