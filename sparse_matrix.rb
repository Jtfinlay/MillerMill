# encoding: utf-8
#
# = SparseMatrix.rb
#
# An implementation of Spare Matrix
#
# Authors: Evan Degraff, James Finlay
##

require 'matrix'

#
# The +SparseMatrix+ class represents a mathematical sparse matrix. It
# provides enhanced features for creating matrices, operating on them
# arithmetically and algebraically, and determining their mathematical
# properties.
#
# The +SparseMatrix+ class relies on the +Matrix+ class to act as a delegate
# in the event that an optimized method is not implemented.
#
class SparseMatrix
	attr_accessor :coords
	
	def initialize(map)
		@coords = map
	end
	
	#
	# Converts a matrix into the hash format, where the values are stored
	# under the form: {"x,y", v}
	#
	def SparseMatrix.fromMatrix(matrix)
		map = Hash.new
		
		matrix.row_vectors().each_with_index do |row, y|
			row.each_with_index do |v, x|
				if v != 0
					map["#{x},#{y}"] = v
				end
			end
		end
		
		new map
	end
end

m = Matrix[ [25, 93, 3], [-1, 66, 14], [0, 34, -554] ]
s = SparseMatrix.fromMatrix(m)
puts "#{s.coords}"
gets