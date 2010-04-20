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

describe "owl:sameAs", 'rule' do
  
  before(:all) do
    @e = engine :engine do |e|
      RdfsPlusRulebook.new(e).rules 
      p = RDF::Statement.new(":Pius", "mit:took_class_at", ":The_Media_Lab");
      h = RDF::Statement.new(":Pius", "owl:sameAs", ":Uzamere");
      d = RDF::Statement.new(":The_Media_Lab", "owl:sameAs", ":Media_Lab");
      e.assert h
      e.assert p
      e.assert d
      e.match
    end
  end
  
  it "should understand individual equivalence when a RDF::Statement subject is owl:sameAs another resource" do
    fact = RDF::Statement.new(":Uzamere", "mit:took_class_at", ":The_Media_Lab");
    f = @e.facts.select {|t| t.subject == ":Uzamere"}
    f.should include(fact)
  end
  
  it "should understand individual equivalence when a RDF::Statement object is owl:sameAs another resource" do
    fact = RDF::Statement.new(":Pius", "mit:took_class_at", ":Media_Lab");
    f = @e.facts.select {|t| t.subject == ":Pius"}
    f.should include(fact)
  end
end
