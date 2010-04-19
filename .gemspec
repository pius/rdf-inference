Gem::Specification.new do |s|
  s.name = "rdf-inference"
  s.version = "0.0.1"
  s.date = "2010-04-19"
  s.summary = "RDF and OWL inference engine for Ruby."
  s.email = "pius+github@alum.mit.edu"
  s.homepage = "http://github.com/pius/rdf-inference"
  s.description = "RDF-Inference is a Ruby library for inferencing over a corpus of RDFS triples.  Implements standard RDFS and RDFS-Plus."
  s.has_rdoc = true
  s.authors = ['Pius Uzamere']
  s.files = ["README.markdown", "Rakefile", ".gemspec", "lib/pomegranate.rb", "lib/pomegranate/rdfs_rulebook.rb", "lib/pomegranate/rdfs_plus_rulebook.rb", "coverage/index.html", "coverage/lib-pomegranate-rdfs_plus_rulebook_rb.html", "coverage/lib-pomegranate_rb.html"]
  s.test_files = ["spec/spec.opts", "spec/spec_helper.rb", "spec/unit/owl_equivalent_class_spec.rb", "spec/unit/owl_equivalent_property_spec.rb", "spec/unit/owl_functional_property_spec.rb", "spec/unit/owl_inverse_functional_property_spec.rb", "spec/unit/owl_inverse_of_spec.rb", "spec/unit/owl_same_as_spec.rb", "spec/unit/owl_symmetric_property_spec.rb", "spec/unit/owl_transitive_property_spec.rb", "spec/unit/rdfs_domain_spec.rb", "spec/unit/rdfs_range_spec.rb", "spec/unit/rdfs_subclass_of_spec.rb", "spec/unit/rdfs_subproperty_of_spec.rb"]
  #s.rdoc_options = ["--main", "README.txt"]
  #s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.add_dependency("ruleby", ["= 0.4"])
end