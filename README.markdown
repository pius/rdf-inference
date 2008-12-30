Pomegranate Release 0.9 (December 30th 2008) 
===================================

**Git**:  [http://github.com/pius/pomegranate](http://github.com/pius/sparql)   
**Author**:    Pius Uzamere, [The Uyiosa Corporation](http://www.uyiosa.com)

**Copyright**: Pius Uzamere © 2008
**License**:  The Lesser GNU Public License


SYNOPSIS
--------

Pomegranate is a Ruby library for inferencing over a corpus of triples with RDFS and OWL properties.  Implements the [RDF Schema Language (RDFs)](http://www.w3.org/TR/rdf-schema/) properties as a set of production rules.  The rules are executed by [Ruleby](http://ruleby.org), a forward-chaining Ruby inferencing engine that implements the Rete algorithm.


FEATURE LIST
------------
                                                                              
1. **Pomegranate can inference over basic RDFS**: When finished, this library will have a full test suite and can serve as a maintainable reference implementation of an RDFS inferencer in Ruby.  In particular, the following statements are supported:

*  rdfs:subClassOf
*  rdfs:subPropertyOf
*  rdfs:domain
*  rdfs:range


2.  **Pomegranate can inference over RDFS-Plus (RDFS plus a small subset of OWL)**: RDFS-Plus, as defined in "Semantic Web for the Working Ontologist" is RDFS plus a small subset of OWL, commonly used in the field.  In particular, the following statements are supported:

*  rdfs:subClassOf
*  rdfs:subPropertyOf
*  rdfs:domain
*  rdfs:range
*  owl:inverseOf
*  owl:SymmetricProperty
*  owl:TransitiveProperty
*  owl:equivalentClass
*  owl:equivalentProperty
*  owl:sameAs
*  owl:FunctionalProperty
*  owl:InverseFunctionalProperty


USAGE
-----

1. **Make Sure You've Got the Dependencies installed**

Pomegranate depends on Ruleby (http://ruleby.org).

  > sudo gem install ruleby

2. **Install the Gem**

Make sure you've upgraded to RubyGems 1.2.  Then, if you've never installed a gem from GitHub before then do this:

  > gem sources -a http://gems.github.com (you only have to do this once)

Then:

  > sudo gem install pius-pomegranate


3. **Require the gem in your code, play with it**


4. **Contribute!**

Fork my repository (http://github.com/pius/pomegranate), make some changes, and send along a pull request!

The best way to contribute is to add a unit test for a specific OWL property that does not parse and then add (and/or tweak) rules such that your new test case plus all the others pass.
                                                                              

COPYRIGHT
---------                                                                 

Pomegranate was created in 2008 by Pius Uzamere (pius -AT- alum -DOT- mit -DOT- edu) and is    
licensed under the LGPL.
