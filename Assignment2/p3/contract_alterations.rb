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
    # No invariants
  end

  def pre_file_creation(file_name)
    assert file_name.is_a?(String), "File name must be a String"
    assert !File.exists?(file_name), "File cannot already exist"
  end

  def post_file_creation(file_name)
    assert File.exists?(file_name), "File should have been created"
  end

  def pre_file_modified(file_name)
    assert file_name.is_a?(String), "File name must be a String"
    assert File.exists? file_name, "File must already exist"
  end

  def post_file_modified()
    # No post conditions
  end

  def pre_file_destroyed(file_name)
    assert file_name.is_a?(String), "File name must be a String"
    assert File.exists? file_name, "File must already exist"
  end

  def post_file_destroyed(file_name)
    assert !File.exists? file_name, "File should have been destroyed"
  end

end
