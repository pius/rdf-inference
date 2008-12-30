# This file is part of Pomegranate
# 
# Pomegranate is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# Pomegranate is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
# 
# You should have received a copy of the GNU Lesser General Public License
# along with Pomegranate.  If not, see <http://www.gnu.org/licenses/>.


require 'rubygems'
require 'pathname'
require 'ruleby'
include Ruleby

class Pathname
  def /(path)
    (self + path).expand_path
  end
end # class Pathname

dir = Pathname(__FILE__).dirname.expand_path / 'pomegranate'
require dir / 'rdfs_plus_rulebook'