# frozen-string-literal: true

require 'numo/narray'
require 'numo/linalg/linalg'
require 'numo/openblas/version'
require 'numo/openblas/openblas'

puts "#{__dir__}"
puts File.expand_path("#{__dir__}/../../vendor/lib/")
Dir.foreach(File.expand_path("#{__dir__}/../../vendor/lib/")) { |f| puts f }

if RbConfig::CONFIG['host_os'] =~ /mswin|msys|mingw|cygwin/
  module Numo
    module Linalg
      module Loader
        module_function

        def load_openblas(lib_dir)
          openblas_path = "#{lib_dir}/libopenblas.dll.a"
          Numo::Linalg::Blas.dlopen(openblas_path)
          Numo::Linalg::Lapack.dlopen(openblas_path)
          @@libs = [openblas_path]
        end
      end
    end
  end
end

Numo::Linalg::Loader.load_openblas(File.expand_path("#{__dir__}/../../vendor/lib/"))
