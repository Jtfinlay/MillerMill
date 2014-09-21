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

	#
	# Creates a sparse matrix. Supports as parameters:
	# Matrix
	#
	def initialize(*args)
		if args.size == 1
			from_matrix(args[0]) if args[0].is_a? Matrix
		end
	end

	#
	# Converts a matrix into the hash format, where the values are stored
	# under the form: {"x,y", v}
	#
	def from_matrix(matrix)
		@coords = Hash.new
		@row_size = matrix.row_size
		@column_size = matrix.column_size

		matrix.row_vectors().each_with_index do |row, y|
			row.each_with_index do |v, x|
				@coords["#{x},#{y}"] = v if v != 0
			end
		end
	end

	#
	# Converts stored hash into original matrix
	#
	def to_matrix
		rows= Matrix.zero(@row_size, @column_size).to_a
		@coords.each_key do |key|
			x, y = split_xy(key)
			rows[y][x] = @coords[key]
		end
		Matrix.rows(rows)
	end

	#
	# Splits the key string into x and y values, and returns them as 
	# integers.
	#
	def split_xy(key_string)
		split_string = key_string.split(",")
		return split_string[0].to_i, split_string[1].to_i
	end

end

#
# Temporary Test Code
#
m = Matrix[ [25, 93, 3], [-1, 66, 14], [0, 34, -554] ]
s = SparseMatrix.new(m)

puts "#{s.coords}"
gets

m = s.to_matrix
puts m.to_s
gets
