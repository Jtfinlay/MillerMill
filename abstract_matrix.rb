# encoding: utf-8
#
# = abstract_matrix.rb
#
# An implementation of Spare Matrix
#
# Authors: Evan Degraff, James Finlay
##

require 'matrix'

#
# The +AbstractMatrix+ class represents an sparse matrix class. It
# provides enhanced features for creating matrices, operating on them
# arithmetically and algebraically, and determining their mathematical
# properties.
#
# The +AbstractMatrix+ class relies on the +Matrix+ class to act as a delegate
# in the event that an optimized method is not implemented.
#
class AbstractMatrix
	@row_size
	@column_size
	
	def initialize(*args)
	end

	def to_matrix
	end
	
	#
	# This coerce method provides support for Ruby type coercion.
	# This coercison is used to convert to a Matrix object when
	# there is a conflict.
	#
	def coerce(m)
		case m
		when Matrix
			return m, self.to_matrix
		end
	end
	
	#
	# This method is called if a method DNE. In this case, we use
	# the Matrix library as a delegate and try to call its function.
	#
	# This specific implementation allows delegation of object methods
	#
	def method_missing(method, *args)
		return AbstractMatrix.cast(self.to_matrix.send(method, *args))
	end

	#
	# This method is called if a method DNE. In this case, we use
	# the Matrix library as a delegate and try to call its function.
	#
	# This specific implementation allows delegation of class methods
	#
	def AbstractMatrix.method_missing(method, *args)
		return AbstractMatrix.cast(Matrix.send(method, *args))
	end
	
	#
	# If Matrix, then cast to SparseMatrix
	#
	def AbstractMatrix.cast(m)
		return SparseMatrixFactory.create_matrix(m) if m.is_a? Matrix
		return m
	end

end