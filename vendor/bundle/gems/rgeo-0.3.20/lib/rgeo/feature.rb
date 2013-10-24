# -----------------------------------------------------------------------------
#
# Features namespace for RGeo
#
# -----------------------------------------------------------------------------
# Copyright 2010-2012 Daniel Azuma
#
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice,
#   this list of conditions and the following disclaimer.
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
# * Neither the name of the copyright holder, nor the names of any other
#   contributors to this software, may be used to endorse or promote products
#   derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
# -----------------------------------------------------------------------------
;


module RGeo


  # The Feature namespace contains interfaces and general tools for
  # implementations of the Open Geospatial Consortium Simple Features
  # Specification (SFS), version 1.1.0.
  #
  # Each interface is defined as a module, and is provided primarily for
  # the sake of documentation. Implementations do not necessarily include
  # the modules themselves. Therefore, you should not depend on the
  # kind_of? method to check type. Instead, each interface module will
  # provide a check_type class method (and a corresponding === operator
  # to support case-when constructs).
  #
  # In addition, a Factory interface is defined here. A factory is an
  # object that knows how to construct geometry instances for a given
  # implementation. Each implementation's front-end consists of a way to
  # create factories. Those factories, in turn, provide the api for
  # building the features themselves. Note that, like the geometry
  # modules, the Factory module itself may not actually be included in a
  # factory implementation.
  #
  # Any particular implementation may extend these interfaces to provide
  # implementation-specific features beyond what is stated in the SFS
  # itself. The implementation should separately document any such
  # extensions that it may provide.

  module Feature
  end


end


# Implementation files
require 'rgeo/feature/factory'
require 'rgeo/feature/mixins'
require 'rgeo/feature/types'
require 'rgeo/feature/geometry'
require 'rgeo/feature/point'
require 'rgeo/feature/curve'
require 'rgeo/feature/line_string'
require 'rgeo/feature/linear_ring'
require 'rgeo/feature/line'
require 'rgeo/feature/surface'
require 'rgeo/feature/polygon'
require 'rgeo/feature/geometry_collection'
require 'rgeo/feature/multi_point'
require 'rgeo/feature/multi_curve'
require 'rgeo/feature/multi_line_string'
require 'rgeo/feature/multi_surface'
require 'rgeo/feature/multi_polygon'
require 'rgeo/feature/factory_generator'
