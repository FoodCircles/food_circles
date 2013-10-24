# -----------------------------------------------------------------------------
#
# A tool for hacking ActiveRecord's rake tasks
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


    # A set of tools for hacking ActiveRecord's Rake tasks.

    module TaskHacker


      class Action  # :nodoc:

        def initialize(env_, pattern_, proc_)
          @env = env_
          @pattern = pattern_
          @proc = proc_
        end

        def call(task_)
          env_ = @env || ::Rails.env || 'development'
          config_ = ::ActiveRecord::Base.configurations[env_]
          if config_
            if @pattern === config_['adapter']
              task_.actions.delete_if{ |a_| a_ != self }
              @proc.call(config_)
            end
          else
            puts "WARNING: Could not find environment #{env_.inspect} in your database.yml"
          end
        end

        def arity
          1
        end

      end


      class << self


        # Modify a named ActiveRecord rake task.
        # The task must be of the form that hinges on the database adapter
        # name. You must provide the fully-qualified name of the rake task
        # to modify, the Rails environment for which to get the database
        # configuration (which may be nil to use the current Rails.env),
        # a Regexp or String identifying the adapter name for which to
        # modify the rake task, and a block. If the database adapter
        # associated with the given environment matches the given pattern,
        # then the rake task's action(s) will be replaced by the given
        # block. The block will be passed the environment's database
        # configuration hash.

        def modify(name_, env_, pattern_, &block_)
          if ::Rake::Task.task_defined?(name_)
            ::Rake::Task[name_].actions.unshift(Action.new(env_, pattern_, block_))
          end
        end


      end


    end


  end

end
