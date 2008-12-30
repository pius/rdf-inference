# This file is part of the Pomegranate project (http://pius.github.com/pomegranate/)
#
# This application is free software; you can redistribute it and/or
# modify it under the terms of the Ruby license defined in the
# LICENSE.txt file.
# 
# Copyright (c) 2008 Pius Uzamere. All rights reserved.
#
# * Authors: Pius Uzamere
#

$LOAD_PATH << File.join(File.dirname(__FILE__), '../lib/')
require 'rubygems'
require 'ruleby'

include Ruleby

class Triple
  def initialize(subject,predicate,object)
    @subject = subject
    @predicate = predicate
    @object= object
  end  
  attr:subject, true
  attr:predicate, true
  attr:object, true
  
  def ==(obj)
    (@subject == obj.subject) && (@object == obj.object) && (@predicate == obj.predicate)
  end
  
end


class RdfsRulebook < Ruleby::Rulebook
  
  def rules
    rdfs_rules
  end
  
  #nodoc
  def rdfs_rules
    
    ## 
    # Implements Type Propagation through rdfs:subClassOf
    #
    # ==== Semantics
    #   Given:
    #   A rdfs:subClassOf B
    #   r rdf:type A
    #
    #   Infer:
    #   r rdf:type B
    #
    # ==== Example
    #   p = Triple.new(":Pius", "rdf:type", ":male"); 
    #   h = Triple.new(":male", "rdfs:subClassOf", ":human") 
    #   assert p; assert h;  #=> infers a triple ~= Triple.new(":Pius", "rdf:type", ":human")
    #
    # @author Pius Uzamere
    def rdfs_sub_class_of
    end
    
    rule :rdfs_sub_class_of,
    #TODO: add a patch to ruleby whereby the parser will raise when there's a no method error (e.g. m.subj)
      [Triple,:fact,{m.subject => :subj, m.object=>:obj},m.predicate=="rdf:type"],
      [Triple,:ont_statement,{m.object => :inferred_class },m.predicate=="rdfs:subClassOf", m.subject == b(:obj)],
      [:not, Triple, m.predicate=="rdf:type", m.subject==b(:subj), m.object==b(:inferred_class)] do |v|
        inferred_class = v[:ont_statement].object
        subj = v[:fact].subject
        assert Triple.new(subj, "rdf:type", inferred_class)
        puts "Made type inference based on rdfs:subClassOf: Triple(#{subj}, rdf:type, #{inferred_class})"  
    end
    

    ## 
    # Implements Type Propagation through rdfs:subPropertyOf
    #
    # ==== Semantics
    #   Given:
    #   P rdfs:subPropertyOf R
    #   A P B
    #
    #   Infer:
    #   A R B
    #
    # ==== Example
    #   p = Triple.new(":Pius", "mit:majored_in", ":Course_6"); 
    #   h = Triple.new("mit:majored_in", "rdfs:subPropertyOf", "mit:took_some_classes_in") 
    #   assert p; assert h;  #=> infers a triple ~= Triple.new(":Pius", "mit:took_some_classes_in", ":Course_6")
    #
    # @author Pius Uzamere
    def rdfs_sub_property_of
    end
    
    rule :rdfs_sub_property_of,
      [Triple,:fact,{m.predicate=>:pred, m.subject => :subj, m.object=>:obj}],
      [Triple,:ont_statement, {m.object => :inferred_pred}, m.predicate=="rdfs:subPropertyOf", m.subject == b(:pred)],
      [:not, Triple, m.predicate==b(:inferred_pred), m.subject==b(:subj), m.object==b(:obj)] do |v|
        inferred_property = v[:ont_statement].object
        subj = v[:fact].subject
        obj = v[:fact].object
        assert Triple.new(subj, inferred_property, obj)
        puts "Made type inference based on subPropertyOf: Triple(#{subj},#{inferred_property}, #{obj})"  
    end
    
    ## 
    # Implements Type Propagation through rdfs:domain
    #
    # ==== Semantics
    #   Given:
    #   P rdfs:domain D
    #   x P y
    #
    #   Infer:
    #   x rdf:type D
    #
    # ==== Example
    #   p = Triple.new("mit:majored_in", "rdfs:domain", ":student"); 
    #   h = Triple.new(":Pius", "mit:majored_in", ":Course_17") 
    #   assert p; assert h;  #=> infers a triple ~= Triple.new(":Pius", "rdf:type", ":student")
    #
    # @author Pius Uzamere
    def rdfs_domain
    end
    
    rule :rdfs_domain,
      [Triple,:fact,{m.predicate=>:pred}],
      [Triple,:ont_statement,m.predicate=="rdfs:domain", m.subject == b(:pred)] do |v|
        inferred_type = v[:ont_statement].object
        subj = v[:fact].subject
        assert Triple.new(subj, "rdf:type", inferred_type)
        puts "Made type inference based on rdfs:domain: Triple(#{subj},rdf:type, #{inferred_type})"  
    end
    
    ## 
    # Implements Type Propagation through rdfs:range
    #
    # ==== Semantics
    #   Given:
    #   P rdfs:range R
    #   x P y
    #
    #   Infer:
    #   y rdf:type R
    #
    # ==== Example
    #   p = Triple.new("mit:majored_in", "rdfs:range", ":major"); 
    #   h = Triple.new(":Pius", "mit:majored_in", ":Course_17") 
    #   assert p; assert h;  #=> infers a triple ~= Triple.new(":Pius", "rdf:type", ":student")
    #
    # @author Pius Uzamere
    def rdfs_range
    end
    
    rule :rdfs_range,
      [Triple,:fact,{m.predicate=>:pred}],
      [Triple,:ont_statement,m.predicate=="rdfs:range", m.subject == b(:pred)] do |v|
        inferred_type = v[:ont_statement].object
        subj = v[:fact].object
        assert Triple.new(subj, "rdf:type", inferred_type)
        puts "Made type inference based on rdfs:range: Triple(#{subj},rdf:type, #{inferred_type})"  
    end
    
  end
end

include Ruleby
engine :engine do |e|
  #the engine takes an unreasonably long time to inspect -- consider patching Ruleby
  RdfsRulebook.new(e).rdfs_rules 
  
  q = Triple.new(":Pius", "mit:majored_in", ":Course_6"); 
  r = Triple.new("mit:majored_in", "rdfs:subPropertyOf", "mit:took_some_classes_in")
  
  e.assert q
  e.assert r
  
  e.match

  # p = Triple.new(":Pius", "rdf:type", ":male")
  # h = Triple.new(":male", "rdfs:subClassOf", ":human") 
  # e.assert p
  # e.assert h
  # e.match
  # puts "matching facts"
  # puts e.facts
end