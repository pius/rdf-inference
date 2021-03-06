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

$LOAD_PATH << File.join(File.dirname(__FILE__), '../lib/')
require 'lib/pomegranate/rdfs_rulebook'

class RdfsPlusRulebook < RdfsRulebook
  
  def rules
    rdfs_rules
    rdfs_plus_rules
  end
  
  #nodoc
  def rdfs_plus_rules
    ## 
    # Implements Type Propagation through owl:inverseOf
    #
    # ==== Semantics
    #   Given:
    #   P owl:inverseOf Q
    #   x P y
    #
    #   Infer:
    #   y Q x
    #
    # ==== Example
    #   p = RDF::Statement.new(":Pius", ":took_a_class_taught_by", ":Winston"); 
    #   h = RDF::Statement.new(":took_a_class_taught_by", "owl:inverseOf", ":taught") 
    #   assert p; assert h;  #=> infers a RDF::Statement ~= RDF::Statement.new(":Winston", "taught", ":Pius")
    #
    # @author Pius Uzamere
    def owl_inverse_of
    end
    
    rule :owl_inverse_of,
      [RDF::Statement,:fact,{m.predicate=>:pred, m.object => :new_subj, m.subject => :new_obj}],
      [RDF::Statement,:ont_statement,{m.object => :inferred_pred},m.predicate=="owl:inverseOf", m.subject == b(:pred)],
      [:not, RDF::Statement, m.predicate==b(:inferred_pred), m.subject==b(:new_subj), m.object==b(:new_obj)] do |v|
        inferred_property = v[:ont_statement].object
        obj = v[:fact].subject
        subj = v[:fact].object
        assert RDF::Statement.new(subj, inferred_property, obj)
        puts "Made type inference based on owl:inverseOf: RDF::Statement(#{subj}, #{inferred_property}, #{obj})"
    end
    
    ## 
    # Implements Type Propagation through owl:SymmetricProperty
    #
    # ==== Semantics
    #   Given:
    #   P rdf:type owl:SymmetricProperty
    #
    #   Infer:
    #   P owl:inverseOf P
    #
    # ==== Example
    #   p = RDF::Statement.new(":Pius", ":was_in_a_class_with", ":Adam"); 
    #   h = RDF::Statement.new(":was_in_a_class_with", "rdf:type", "owl:SymmetricProperty") 
    #   assert p; assert h;  #=> infers a RDF::Statement ~= RDF::Statement.new(":Adam", ":was_in_a_class_with", ":Pius")
    #
    # @author Pius Uzamere
    def owl_symmetric_property
    end
    
    rule :owl_symmetric_property,
      [RDF::Statement,:ont_statement,m.predicate=="rdf:type",m.object=="owl:SymmetricProperty"] do |v|
        prop = v[:ont_statement].subject
        assert RDF::Statement.new(prop, "owl:inverseOf", prop)
        puts "Made type inference based on owl:SymmetricProperty: RDF::Statement(#{prop}, owl:inverseOf, #{prop})"
    end
    
    ## 
    # Implements Type Propagation through owl:TransitiveProperty
    #
    # ==== Semantics
    #   Given:
    #   P rdf:type owl:TransitiveProperty
    #   X P Y
    #   X P Z
    #
    #   Infer:
    #   X P Z
    #
    # ==== Example
    #   p = RDF::Statement.new(":Dirichlet", ":is_an_academic_ancestor_of", ":Minsky"); 
    #   h = RDF::Statement.new(":Poisson", ":is_an_academic_ancestor_of", ":Dirichlet");
    #   j = RDF::Statement.new(":is_an_academic_ancestor_of", "rdf:type", "owl:TransitiveProperty"); 
    #   assert p; assert h; assert j;  #=> infers a RDF::Statement ~= RDF::Statement.new(":Poisson", ":is_an_academic_ancestor_of", ":Minsky")
    #
    # @author Pius Uzamere
    def owl_transitive_property
    end
        
    rule :owl_transitive_property,
      [RDF::Statement,:ont_statement,{m.subject => :trans_prop},m.predicate=="rdf:type",m.object=="owl:TransitiveProperty"],
      [RDF::Statement,:fact1,{m.predicate=>:predi, m.subject => :sub, m.object => :trans_obj}, m.predicate == b(:trans_prop), m.subject.not== m.object],
      [RDF::Statement,:fact2, m.predicate==b(:predi), m.subject==b(:trans_obj), m.predicate.not=="owl:inverseOf", m.object.not== b(:sub) ] do |v|
        subj = v[:fact1].subject
        obj = v[:fact2].object
        prop = v[:ont_statement].subject
        assert RDF::Statement.new(subj, prop, obj)
        puts "Made type inference based on owl:TransitiveProperty: RDF::Statement(#{subj}, #{prop}, #{obj})"
    end
    
    ## 
    # Implements Class Equivalence through owl:equivalentClass
    #
    # ==== Semantics
    #   Given:
    #   A owl:equivalentClass B
    #   r rdf:type A
    #   
    #   Infer:
    #   r rdf:type B
    #
    #      AND
    #
    #   Given:
    #   C owl:equivalentClass D
    #   C rdfs:subClassOf D
    #   z rdf:type D
    #
    #   Infer:
    #   z rdf:type C
    #
    # ==== Example
    #   p = RDF::Statement.new("mit:class", "owl:equivalentClass", "mit:subject"); 
    #   h = RDF::Statement.new(":6.111", "rdf:type", "mit:class");
    #   assert p; assert h; #=> infers a RDF::Statement ~= RDF::Statement.new(":6.111", ":rdf:type", ":mit:subject")
    #
    # @author Pius Uzamere
    def owl_equivalent_class
    end
    
    rule :owl_equivalent_class,
      [RDF::Statement,:ont_statement,m.predicate=="owl:equivalentClass"] do |v|
        assert RDF::Statement.new("owl:equivalentClass", "rdf:type", "owl:SymmetricProperty")
        assert RDF::Statement.new("owl:equivalentClass", "rdfs:subPropertyOf", "rdfs:subClassOf")
        #this is cute . . . only annoying thing is that you don't get the downstream explanation of the inferences
    end
    
    
    ## 
    # Implements Property Equivalence through owl:equivalentProperty
    #
    # ==== Semantics
    #   Given:
    #   A owl:equivalentProperty B
    #   r A c
    #   
    #   Infer:
    #   r B C
    #
    #      AND
    #
    #   Given:
    #   C owl:equivalentClass D
    #   C rdfs:subClassOf D
    #   z rdf:type D
    #
    #   Infer:
    #   z rdf:type C
    #
    # ==== Example
    #   p = RDF::Statement.new("mit:took_class", "owl:equivalentProperty", "mit:took_course"); 
    #   h = RDF::Statement.new(":Pius", "mit:took_course", ":6.111");
    #   assert p; assert h; #=> infers a RDF::Statement ~= RDF::Statement.new(":Pius", "mit:took_class", ":6.111")
    #
    # @author Pius Uzamere
    
    def owl_equivalent_property
    end
    
    rule :owl_equivalent_property,
      [RDF::Statement,:ont_statement,m.predicate=="owl:equivalentProperty"] do |v|
        assert RDF::Statement.new("owl:equivalentProperty", "rdf:type", "owl:SymmetricProperty")
        assert RDF::Statement.new("owl:equivalentProperty", "rdfs:subPropertyOf", "rdfs:subPropertyOf")
        #this is cute . . . only annoying thing is that you don't get the downstream explanation of the inferences
    end

    ## 
    # Implements Individual Equivalence through owl:sameAs
    #
    # ==== Semantics
    #   Given:
    #   x owl:sameAs y
    #   o P x
    #   
    #   Infer:
    #   o P y
    #
    #      AND
    #
    #   Given:
    #   x owl:sameAs y
    #   x P o
    #
    #   Infer:
    #   z rdf:type C
    #
    # ==== Example
    #   p = RDF::Statement.new(":Pius", "owl:sameAs", ":Uzamere"); 
    #   h = RDF::Statement.new(":Pius", "mit:took_course", ":6.171");
    #   assert p; assert h; #=> infers a RDF::Statement ~= RDF::Statement.new(":Uzamere", "mit:took_course", ":6.171")
    #
    # @author Pius Uzamere
    
    def owl_same_as
    end
    
    rule :owl_same_as_symmetricity,
      [RDF::Statement,:ont_statement, m.predicate=="owl:sameAs"] do |v|
      assert RDF::Statement.new("owl:sameAs", "rdf:type", "owl:SymmetricProperty")
      puts "asserting the symmetricity of owl:sameAs"
    end
    
    
    rule :owl_same_as_when_subject,

      [RDF::Statement,:ont_statement,{m.subject => :original, m.object => :doppelganger}, m.predicate=="owl:sameAs"],
      [RDF::Statement,:fact, {m.predicate => :p, m.object => :common_object}, m.subject == b(:original), m.subject.not== b(:doppelganger), m.predicate.not== "owl:sameAs"],
      [:not, RDF::Statement, m.predicate==b(:p), m.subject==b(:doppelganger), m.object==b(:common_object)] do |v|

      subj = v[:ont_statement].object
      pred = v[:fact].predicate
      obj = v[:fact].object
      
      puts "Made type inference based on owl:sameAs: RDF::Statement(#{subj}, #{pred}, #{obj})"
      assert RDF::Statement.new(subj, pred, obj)
      #this is cute . . . only annoying thing is that you don't get the downstream explanation of the inferences
    end
    
    rule :owl_same_as_when_object,
      [RDF::Statement,:ont_statement,{m.object => :original, m.subject => :doppelganger}, m.predicate=="owl:sameAs"],
      [RDF::Statement,:fact, {m.predicate => :p, m.object => :ob, m.subject => :common_subject}, m.object == b(:original), m.object.not== b(:doppelganger), m.predicate.not== "owl:sameAs"],
      [:not, RDF::Statement, m.predicate==b(:p), m.subject==b(:common_subject), m.object==b(:doppelganger)] do |v|

      obj = v[:ont_statement].subject
      pred = v[:fact].predicate
      subj = v[:fact].subject
      
      puts "Made type inference based on owl:sameAs: RDF::Statement(#{subj}, #{pred}, #{obj})"
      assert RDF::Statement.new(subj, pred, obj)
      #this is cute . . . only annoying thing is that you don't get the downstream explanation of the inferences
    end
    
    ## 
    # owl:FunctionalProperty
    #
    # ==== Semantics
    #   Given:
    #   P rdf:type owl:FunctionalProperty
    #   x P y
    #   x P z
    #   
    #   Infer:
    #   y owl:sameAs z
    #
    # ==== Example
    #   p = RDF::Statement.new("mit:had_academic_advisor", "rdf:type", "owl:FunctionalProperty");
    #   h = RDF::Statement.new(":Pius", "mit:had_academic_advisor", ":Hal");
    #   d = RDF::Statement.new(":Pius", "mit:had_academic_advisor", ":Dude_Who_Wrote_SICP_With_Gerald_Sussman");
    #   assert p; assert h; assert d; #=> infers a RDF::Statement ~= RDF::Statement.new(":Hal", "owl:sameAs", ":Dude_Who_Wrote_SICP_With_Gerald_Sussman")
    #
    # @author Pius Uzamere
    
    def owl_functional_property
    end
    
    rule :owl_functional_property,
      [RDF::Statement,:ont_statement,{m.subject => :the_prop}, m.predicate == "rdf:type", m.object=="owl:FunctionalProperty"],
      [RDF::Statement,:fact1, {m.subject => :common_subject, m.object => :first_object}, m.predicate == b(:the_prop)],
      [RDF::Statement,:fact2, {m.object => :second_object}, m.subject == b(:common_subject), m.predicate == b(:the_prop)] do |v|

        subj = v[:fact1].object
        obj = v[:fact2].object
        
        puts "Made type inference based on owl:FunctionalProperty: RDF::Statement(#{subj}, owl:sameAs, #{obj})"
        assert RDF::Statement.new(subj, "owl:sameAs", obj)
    end
    
    ## 
    # owl:InverseFunctionalProperty
    #
    # ==== Semantics
    #   Given:
    #   P rdf:type owl:InverseFunctionalProperty
    #   z P x
    #   y P x
    #   
    #   Infer:
    #   y owl:sameAs z
    #
    # ==== Example
    #   p = RDF::Statement.new("mit:lived_alone_fall_2004_in", "rdf:type", "owl:FunctionalProperty");
    #   h = RDF::Statement.new(":Pius", "mit:lived_alone_fall_2004_in", ":pomegranate_314_at_Next_House");
    #   d = RDF::Statement.new(":2004_UA_President", "mit:lived_alone_fall_2004_in", ":pomegranate_314_at_Next_House");
    #   assert p; assert h; assert d; #=> infers a RDF::Statement ~= RDF::Statement.new(":Pius", "owl:sameAs", ":2004_UA_President")
    #
    # @author Pius Uzamere
    
    def owl_inverse_functional_property
    end
    
    rule :owl_inverse_functional_property,
      [RDF::Statement,:ont_statement,{m.subject => :the_prop}, m.predicate == "rdf:type", m.object=="owl:InverseFunctionalProperty"],
      [RDF::Statement,:fact1, {m.object => :common_object, m.subject => :first_subject}, m.predicate == b(:the_prop)],
      [RDF::Statement,:fact2, {m.subject => :second_subject}, m.object == b(:common_object), m.predicate == b(:the_prop)] do |v|

        subj = v[:fact1].subject
        obj = v[:fact2].subject
        
        puts "Made type inference based on owl:InverseFunctionalProperty: RDF::Statement(#{subj}, owl:sameAs, #{obj})"
        assert RDF::Statement.new(subj, "owl:sameAs", obj)
    end

  end
end