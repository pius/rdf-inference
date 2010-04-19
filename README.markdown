RDF-Inference Release 0.0.1 (April 19th 2010) 
===================================

**Git**:  [http://github.com/pius/rdf-inference](http://github.com/pius/rdf-inference)   
**Author**:    Pius Uzamere

**Copyright**: Pius Uzamere © 2010
**License**:  MIT License


SYNOPSIS
--------

RDF-Inference is a Ruby library for inferencing over a corpus of triples with RDFS and OWL properties.  Implements the [RDF Schema Language (RDFs)](http://www.w3.org/TR/rdf-schema/) properties as a set of production rules.  The rules are executed by [Ruleby](http://ruleby.org), a forward-chaining Ruby inferencing engine that implements the Rete algorithm.


FEATURE LIST
------------
                                                                              
1. **RDF-Inference can inference over basic RDFS**: When finished, this library will have a full test suite and can serve as a maintainable reference implementation of an RDFS inferencer in Ruby.  In particular, the following statements are supported:

*  rdfs:subClassOf
*  rdfs:subPropertyOf
*  rdfs:domain
*  rdfs:range


2.  **RDF-Inference can inference over RDFS-Plus (RDFS plus a small subset of OWL)**: RDFS-Plus, as defined in "Semantic Web for the Working Ontologist" is RDFS plus a small subset of OWL, commonly used in the field.  In particular, the following statements are supported:

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

RDF-Inference depends on Ruleby (http://ruleby.org).

  > sudo gem install ruleby

2. **Clone the Repository and Install the Gem from Source**

  > git clone git://github.com/pius/rdf-inference.git 
  > cd rdf-inference
  > gem build rdf-inference.gemspec
  > sudo gem install rdf-inference


3. **Require the gem in your code, play with it**

For usage, the best thing is to click through the [documentation](http://pius.github.com/rdf-inference).  I tried to make it really thorough.  If you need more guidance, check out the specs, which demonstrate precisely how to instantiate triples and run the inferencing engine.


4. **Contribute!**

Fork my repository (http://github.com/pius/rdf-inference), make some changes, and send along a pull request!

The best way to contribute is to add a unit test for a specific OWL property that does not parse and then add (and/or tweak) rules such that your new test case plus all the others pass.
                                                                              

COPYRIGHT
---------                                                                 

RDF-Inference was created in 2008 by Pius Uzamere (pius -AT- alum -DOT- mit -DOT- edu) and is    
licensed under the MIT License.
