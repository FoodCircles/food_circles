# -----------------------------------------------------------------------------
#
# Geometry mixin for JSON serialization
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

  module ActiveRecord


    # This module is mixed into all geometry objects. It provides an
    # as_json method so that ActiveRecord knows how to generate JSON
    # for a geometry-valued field.

    module GeometryMixin


      # The default JSON generator Proc. Renders geometry fields as WKT.
      DEFAULT_JSON_GENERATOR = ::Proc.new{ |geom_| geom_.to_s }

      @json_generator = DEFAULT_JSON_GENERATOR


      # Set the style of JSON generation used for geometry fields in an
      # ActiveRecord model by default. You may pass nil to use
      # DEFAULT_JSON_GENERATOR, a proc that takes a geometry as the
      # argument and returns an object that can be converted to JSON
      # (i.e. usually a hash or string), or one of the following symbolic
      # values:
      #
      # <tt>:wkt</tt>::
      #   Well-known text format. (Same as DEFAULT_JSON_GENERATOR.)
      # <tt>:geojson</tt>::
      #   GeoJSON format. Requires the rgeo-geojson gem.

      def self.set_json_generator(value_=nil, &block_)
        if block_ && !value_
          value_ = block_
        elsif value_ == :geojson
          require 'rgeo/geo_json'
          value_ = ::Proc.new{ |geom_| ::RGeo::GeoJSON.encode(geom_) }
        end
        if value_.is_a?(::Proc)
          @json_generator = value_
        else
          @json_generator = DEFAULT_JSON_GENERATOR
        end
      end


      # Given a feature, returns an object that can be serialized as JSON
      # (i.e. usually a hash or string), using the current json_generator.
      # This is used to generate JSON for geometry-valued ActiveRecord
      # fields by default.

      def self.generate_json(geom_)
        @json_generator.call(geom_)
      end


      # Serializes this object as JSON for ActiveRecord.

      def as_json(opts_=nil)
        GeometryMixin.generate_json(self)
      end


    end


  end

end


::RGeo::Feature::MixinCollection::GLOBAL.for_type(::RGeo::Feature::Geometry).
  add(::RGeo::ActiveRecord::GeometryMixin)
