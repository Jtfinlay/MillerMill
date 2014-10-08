
require './sparse_matrix_factory'

#
# This class demonstrates usage of the sparse matrix library.
#
class AssignmentMain

  #
  # How to create
  #
  def AssignmentMain.createSparseMatrix

    # A sparse matrix can be created from 2d arrays or a Matrix object
    sfrom_array = SparseMatrixFactory[[ [0, 0, 5], [1, 0, 5], [6, 0, 0] ]]
    sfrom_matrix = SparseMatrixFactory[Matrix[[0, 0, 5], [1, 0, 5], [6, 0, 0]]]

    # A band matrix can be created in the same way. The factories check
    # whether the input is banded or not, then work with it from there.
    bfrom_array = SparseMatrixFactory[[ [25, 93, 4, 0, 0], [0, 13, 5, 1, 0], [5, 5, 5, 7, 3], [0, 3, 7, 1, 0], [0, 0, 5, 1, 6] ]]
    bfrom_array = SparseMatrixFactory[Matrix[ [25, 93, 4, 0, 0], [0, 13, 5, 1, 0], [5, 5, 5, 7, 3], [0, 3, 7, 1, 0], [0, 0, 5, 1, 6] ]]

    # Insertion
    sfrom_array[0, 0] = 1

    # Retrieval
    puts sfrom_array[0, 0]
  end

  #
  # Basic arithmetic
  #
  def AssignmentMain.addSparseMatrix

    # SparseMatrix object are optimized to handle faster addition and
    # subtraction than their Matrix counterparts.

    # Ensure not banded matrix, but is sparse.
    size = 2000
    m = Matrix.build(size,size){|row,col| (col == size-1 or col == 0) ? 1 : 0}
    s = SparseMatrixFactory[m]

    # Proof of speed
    ti = Time.now
    m_result = m+m
    tf = Time.now
    puts "Matrix: #{tf-ti}"

    ti = Time.now
    s_result = s+s
    tf = Time.now
    puts "SparseMatrix: #{tf-ti}"

  end



end

AssignmentMain.createSparseMatrix
AssignmentMain.addSparseMatrix
