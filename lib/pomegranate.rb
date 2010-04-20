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


require 'rubygems'
require 'pathname'
require 'ruleby'
require 'rdf'
include Ruleby

class Pathname
  def /(path)
    (self + path).expand_path
  end
end # class Pathname

dir = Pathname(__FILE__).dirname.expand_path / 'pomegranate'
require dir / 'rdfs_plus_rulebook'