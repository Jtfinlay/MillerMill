# encoding: utf-8
#
# = band_matrix.rb
#
# An implementation of Band Matrix
#
# Authors: Evan Degraff, James Finlay
##

require './abstract_matrix'

#
# The +BandMatrix+ class represents a mathematical band sparse matrix. It
# provides enhanced features for creating band matrices, operating on them
# arithmetically and algebraically, and determining their mathematical
# properties.
#
# The +BandMatrix+ class inherits from the +SparseMatrix+ class.
#
class BandMatrix < AbstractMatrix
	attr_accessor :data
	@bandwidth

	#
	# Creates a band matrix. Supports as parameters:
	# Matrix
	# 3D Array
	#
	def initialize(*args)
		# TODO - This is nearly the same as SparseMatrix' method. Perhaps
		# we should refactor?
		if args.size == 1
			from_matrix(args[0]) if args[0].is_a? Matrix
			from_arrays(args[0]) if args[0].is_a? Array
		end
	end
	
	#
	# Returns element (+x+,+y+) of the matrix.
	#
	def [](x, y)
		return 0 if !(x-y).between?(-@bandwidth,@bandwidth)
		return @data[y][@bandwidth+x-y]
	end
	
	#
	# Sets element (+x+,+y+) of the matrix to +v+.
	# Ignores values that are not in the band.
	#
	def []=(x, y, v)
		@data[y][@bandwidth+x-y] = v if (x-y).between?(-@bandwidth,@bandwidth)
	end
	
	#
	# Converts a matrix into the compressed 3D array format.
	#
	def from_matrix(matrix)
		@bandwidth = 2 # TODO - Calculate the bandwidth
		@row_size = matrix.row_size
		@column_size = matrix.column_size
		
		@data = Array.new(@bandwidth*2+1){Array.new(@column_size-1,0)}
		
		# TODO - This is nearly same as SparseMatrix's method.
		# Perhaps we could refactor?
		matrix.each_with_index do |v, row, col|
			self.[]=(col,row,v)
		end
	end
	
	#
	# Converts a 3D Array into the compressed 3D array format.
	#
	def from_arrays(arrays)
		@bandwidth = 2 # TODO - Calculate the bandwidth
		@row_size = arrays.size
		@column_size = arrays.first.size
		@data = Array.new(@bandwidth*2+1){Array.new(@column_size-1,0)}
		
		# TODO - This is nearly the same as SparseMatrix' method. Perhaps
		# we should refactor?
		arrays.each_with_index{
			|row, y| row.each_with_index{
				|v, x| self.[]=(x,y,v)
			}
		}
	end
	
	#
	# Converts compressed 3D Array into original matrix
	#
	def to_matrix
		rows = Matrix.zero(@row_size, @column_size).to_a
		rows.each_with_index{
			|row,y| row.each_with_index{
				|v,x| rows[y][x] = self[x,y]
			}
		}
		Matrix.rows(rows)
	end
	
end
