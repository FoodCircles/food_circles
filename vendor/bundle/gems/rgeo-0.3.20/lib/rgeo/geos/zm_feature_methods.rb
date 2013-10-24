# -----------------------------------------------------------------------------
#
# GEOS implementation additions written in Ruby
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

  module Geos


    module ZMGeometryMethods  # :nodoc:

      include Feature::Instance


      def initialize(factory_, zgeometry_, mgeometry_)
        @factory = factory_
        @zgeometry = zgeometry_
        @mgeometry = mgeometry_
      end


      def inspect  # :nodoc:
        "#<#{self.class}:0x#{object_id.to_s(16)} #{as_text.inspect}>"
      end

      def to_s  # :nodoc:
        as_text
      end


      def hash
        @factory.hash ^ @zgeometry.hash ^ @mgeometry.hash
      end


      def factory
        @factory
      end


      def z_geometry
        @zgeometry
      end


      def m_geometry
        @mgeometry
      end


      def dimension
        @zgeometry.dimension
      end


      def geometry_type
        @zgeometry.geometry_type
      end


      def srid
        @factory.srid
      end


      def envelope
        @factory._create_feature(nil, @zgeometry.envelope, @mgeometry.envelope)
      end


      def as_text
        @factory.instance_variable_get(:@wkt_generator).generate(self)
      end


      def as_binary
        @factory.instance_variable_get(:@wkb_generator).generate(self)
      end


      def is_empty?
        @zgeometry.is_empty?
      end


      def is_simple?
        @zgeometry.is_simple?
      end


      def boundary
        @factory._create_feature(nil, @zgeometry.boundary, @mgeometry.boundary)
      end


      def equals?(rhs_)
        @zgeometry.equals?(::RGeo::Feature.cast(rhs_, self).z_geometry)
      end


      def disjoint?(rhs_)
        @zgeometry.disjoint?(::RGeo::Feature.cast(rhs_, self).z_geometry)
      end


      def intersects?(rhs_)
        @zgeometry.intersects?(::RGeo::Feature.cast(rhs_, self).z_geometry)
      end


      def touches?(rhs_)
        @zgeometry.touches?(::RGeo::Feature.cast(rhs_, self).z_geometry)
      end


      def crosses?(rhs_)
        @zgeometry.crosses?(::RGeo::Feature.cast(rhs_, self).z_geometry)
      end


      def within?(rhs_)
        @zgeometry.within?(::RGeo::Feature.cast(rhs_, self).z_geometry)
      end


      def contains?(rhs_)
        @zgeometry.contains?(::RGeo::Feature.cast(rhs_, self).z_geometry)
      end


      def overlaps?(rhs_)
        @zgeometry.overlaps?(::RGeo::Feature.cast(rhs_, self).z_geometry)
      end


      def relate?(rhs_, pattern_)
        @zgeometry.relate?(::RGeo::Feature.cast(rhs_, self).z_geometry, pattern_)
      end
      alias_method :relate, :relate?  # DEPRECATED


      def distance(rhs_)
        @zgeometry.distance(::RGeo::Feature.cast(rhs_, self).z_geometry)
      end


      def buffer(distance_)
        @factory._create_feature(nil, @zgeometry.buffer(distance_), @mgeometry.buffer(distance_))
      end


      def convex_hull
        @factory._create_feature(nil, @zgeometry.convex_hull, @mgeometry.convex_hull)
      end


      def intersection(rhs_)
        rhs_ = ::RGeo::Feature.cast(rhs_, self)
        @factory._create_feature(nil, @zgeometry.intersection(rhs_.z_geometry), @mgeometry.intersection(rhs_.m_geometry))
      end


      def union(rhs_)
        rhs_ = ::RGeo::Feature.cast(rhs_, self)
        @factory._create_feature(nil, @zgeometry.union(rhs_.z_geometry), @mgeometry.union(rhs_.m_geometry))
      end


      def difference(rhs_)
        rhs_ = ::RGeo::Feature.cast(rhs_, self)
        @factory._create_feature(nil, @zgeometry.difference(rhs_.z_geometry), @mgeometry.difference(rhs_.m_geometry))
      end


      def sym_difference(rhs_)
        rhs_ = ::RGeo::Feature.cast(rhs_, self)
        @factory._create_feature(nil, @zgeometry.sym_difference(rhs_.z_geometry), @mgeometry.sym_difference(rhs_.m_geometry))
      end


      def rep_equals?(rhs_)
        rhs_ = ::RGeo::Feature.cast(rhs_, self)
        rhs_.is_a?(self.class) && @factory.eql?(rhs_.factory) && @zgeometry.rep_equals?(rhs_.z_geometry) && @mgeometry.rep_equals?(rhs_.m_geometry)
      end


      alias_method :eql?, :rep_equals?
      alias_method :==, :equals?

      alias_method :-, :difference
      alias_method :+, :union
      alias_method :*, :intersection


      def _copy_state_from(obj_)  # :nodoc:
        @factory = obj_.factory
        @zgeometry = obj_.z_geometry
        @mgeometry = obj_.m_geometry
      end


      def marshal_dump  # :nodoc:
        [@factory, @factory._marshal_wkb_generator.generate(self)]
      end

      def marshal_load(data_)  # :nodoc:
        _copy_state_from(data_[0]._marshal_wkb_parser.parse(data_[1]))
      end


      def encode_with(coder_)  # :nodoc:
        coder_['factory'] = @factory
        coder_['wkt'] = @factory._psych_wkt_generator.generate(self)
      end

      def init_with(coder_)  # :nodoc:
        _copy_state_from(coder_['factory']._psych_wkt_parser.parse(coder_['wkt']))
      end

    end


    module ZMPointMethods  # :nodoc:


      def x
        @zgeometry.x
      end


      def y
        @zgeometry.y
      end


      def z
        @zgeometry.z
      end


      def m
        @mgeometry.m
      end


    end


    module ZMLineStringMethods  # :nodoc:


      def length
        @zgeometry.length
      end


      def start_point
        point_n(0)
      end


      def end_point
        point_n(num_points - 1)
      end


      def is_closed?
        @zgeometry.is_closed?
      end


      def is_ring?
        @zgeometry.is_ring?
      end


      def num_points
        @zgeometry.num_points
      end


      def point_n(n_)
        @factory._create_feature(ZMPointImpl, @zgeometry.point_n(n_), @mgeometry.point_n(n_))
      end


      def points
        result_ = []
        zpoints_ = @zgeometry.points
        mpoints_ = @mgeometry.points
        zpoints_.size.times do |i_|
          result_ << @factory._create_feature(ZMPointImpl, zpoints_[i_], mpoints_[i_])
        end
        result_
      end


    end


    module ZMPolygonMethods  # :nodoc:


      def area
        @zgeometry.area
      end


      def centroid
        @factory._create_feature(ZMPointImpl, @zgeometry.centroid, @mgeometry.centroid)
      end


      def point_on_surface
        @factory._create_feature(ZMPointImpl, @zgeometry.centroid, @mgeometry.centroid)
      end


      def exterior_ring
        @factory._create_feature(ZMLineStringImpl, @zgeometry.exterior_ring, @mgeometry.exterior_ring)
      end


      def num_interior_rings
        @zgeometry.num_interior_rings
      end


      def interior_ring_n(n_)
        @factory._create_feature(ZMLineStringImpl, @zgeometry.interior_ring_n(n_), @mgeometry.interior_ring_n(n_))
      end


      def interior_rings
        result_ = []
        zrings_ = @zgeometry.interior_rings
        mrings_ = @mgeometry.interior_rings
        zrings_.size.times do |i_|
          result_ << @factory._create_feature(ZMLineStringImpl, zrings_[i_], mrings_[i_])
        end
        result_
      end


    end


    module ZMGeometryCollectionMethods  # :nodoc:


      def num_geometries
        @zgeometry.num_geometries
      end
      alias_method :size, :num_geometries


      def geometry_n(n_)
        @factory._create_feature(nil, @zgeometry.geometry_n(n_), @mgeometry.geometry_n(n_))
      end
      alias_method :[], :geometry_n


      def each
        num_geometries.times do |i_|
          yield geometry_n(i_)
        end
      end


      include ::Enumerable


    end


    module ZMMultiLineStringMethods  # :nodoc:


      def length
        @zgeometry.length
      end


      def is_closed?
        @zgeometry.is_closed?
      end


    end


    module ZMMultiPolygonMethods  # :nodoc:


      def area
        @zgeometry.area
      end


      def centroid
        @factory._create_feature(ZMPointImpl, @zgeometry.centroid, @mgeometry.centroid)
      end


      def point_on_surface
        @factory._create_feature(ZMPointImpl, @zgeometry.centroid, @mgeometry.centroid)
      end


    end


  end

end
