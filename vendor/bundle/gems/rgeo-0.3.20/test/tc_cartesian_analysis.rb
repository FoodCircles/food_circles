# -----------------------------------------------------------------------------
#
# Tests for basic GeoJSON usage
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


require 'test/unit'
require 'rgeo'


module RGeo
  module Tests  # :nodoc:

    class TestCartesianAnalysis < ::Test::Unit::TestCase  # :nodoc:


      def setup
        @factory = ::RGeo::Cartesian.simple_factory
      end


      def test_ring_direction_clockwise_triangle
        p1_ = @factory.point(1, 1)
        p2_ = @factory.point(2, 4)
        p3_ = @factory.point(5, 2)
        ring_ = @factory.line_string([p1_, p2_, p3_, p1_])
        assert_equal(-1, ::RGeo::Cartesian::Analysis.ring_direction(ring_))
      end


      def test_ring_direction_counterclockwise_triangle
        p1_ = @factory.point(1, 1)
        p2_ = @factory.point(2, 4)
        p3_ = @factory.point(5, 2)
        ring_ = @factory.line_string([p1_, p3_, p2_, p1_])
        assert_equal(1, ::RGeo::Cartesian::Analysis.ring_direction(ring_))
      end


      def test_ring_direction_clockwise_puckered_quad
        p1_ = @factory.point(1, 1)
        p2_ = @factory.point(2, 6)
        p3_ = @factory.point(3, 3)
        p4_ = @factory.point(5, 2)
        ring_ = @factory.line_string([p1_, p2_, p3_, p4_, p1_])
        assert_equal(-1, ::RGeo::Cartesian::Analysis.ring_direction(ring_))
      end


      def test_ring_direction_counterclockwise_puckered_quad
        p1_ = @factory.point(1, 1)
        p2_ = @factory.point(2, 6)
        p3_ = @factory.point(3, 3)
        p4_ = @factory.point(5, 2)
        ring_ = @factory.line_string([p1_, p4_, p3_, p2_, p1_])
        assert_equal(1, ::RGeo::Cartesian::Analysis.ring_direction(ring_))
      end


      def test_ring_direction_counterclockwise_near_circle
        p1_ = @factory.point(0, -3)
        p2_ = @factory.point(2, -2)
        p3_ = @factory.point(3, 0)
        p4_ = @factory.point(2, 2)
        p5_ = @factory.point(0, 3)
        p6_ = @factory.point(-2, 2)
        p7_ = @factory.point(-3, 0)
        p8_ = @factory.point(-2, -2)
        ring_ = @factory.line_string([p1_, p2_, p3_, p4_, p5_, p6_, p7_, p8_, p1_])
        assert_equal(1, ::RGeo::Cartesian::Analysis.ring_direction(ring_))
      end


    end

  end
end
