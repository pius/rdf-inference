Gem::Specification.new do |s|
  s.name = "pomegranate"
  s.version = "0.9"
  s.date = "2008-12-30"
  s.summary = "RDF and OWL inference engine for Ruby."
  s.email = "pius+github@uyiosa.com"
  s.homepage = "http://github.com/pius/pomegranate"
  s.description = "Pomegranate is a Ruby library for inferencing over a corpus of RDFS triples.  Implements standard RDFS and RDFS-Plus."
  s.has_rdoc = true
  s.authors = ['Pius Uzamere']
  s.files = ["README", "Rakefile", "pomegranate.gemspec", "lib/pomegranate.rb", "lib/pomegranate/rdfs_rulebook.rb", "lib/pomegranate/rdfs_plus_rulebook.rb", "coverage/index.html", "coverage/lib-pomegranate-rdfs_plus_rulebook_rb.html", "coverage/lib-pomegranate_rb.html"]
  s.test_files = ["spec/spec.opts", "spec/fixtures", "spec/spec_helper.rb", "spec/unit/owl_equivalent_class_spec.rb", "spec/unit/owl_equivalent_property_spec.rb", "spec/unit/owl_functional_property_spec.rb", "spec/unit/owl_inverse_functional_property_spec.rb", "spec/unit/owl_inverse_of_spec.rb", "spec/unit/owl_same_as_spec.rb", "spec/unit/owl_symmetric_property_spec.rb", "spec/unit/owl_transitive_property_spec.rb", "spec/unit/rdfs_domain_spec.rb", "spec/unit/rdfs_range_spec.rb", "spec/unit/rdfs_subclass_of_spec.rb", "spec/unit/rdfs_subproperty_of_spec.rb"]
  #s.rdoc_options = ["--main", "README.txt"]
  #s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.add_dependency("ruleby", [">= 0.4"])
end