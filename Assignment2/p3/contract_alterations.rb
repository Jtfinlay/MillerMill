# encoding: utf-8
#
# = contract_alterations.rb
#
# Contracts for alterations.rb
#
# Authors: Evan Degraff, James Finlay
##

require 'test/unit/assertions'

module ContractAlterations
  include Test::Unit::Assertions

  def class_invariant

  end

  def pre_file_creation(file_name)
    assert file_name.is_a?(String), "File name must be a String"
    assert !File.exists?(file_name), "File cannot already exist"

  end

  def post_file_creation()

  end

  def pre_file_modified(file_name)
    assert file_name.is_a?(String), "File name must be a String"
    assert File.exists? file_name, "File must already exist"
  end

  def post_file_modified()

  end

  def pre_file_destroyed(file_name)
    assert file_name.is_a?(String), "File name must be a String"
    assert File.exists? file_name, "File must already exist"
  end

  def post_file_destroyed()

  end

end
