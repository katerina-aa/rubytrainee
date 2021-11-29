# frozen_string_literal: true

require_relative 'models'
require 'json'

# The UserController class is responsible for managing User class
class UserController
  def self.show_all
    User.all.map(&:to_json)
  end

  def self.show_user_by_id(id_value)
    User.find_by_id(id_value)
  end

  def self.show_user_by(key, value)
    User.find_by(key => value)
  end

  def self.create_user(opts)
    User.create(opts)
  end

  def self.delete_user(id_value)
    user = User.find_by_id(id_value)
    user ? user.destroy : nil
  end

  def self.delete_all
    User.destroy_all
  end

  def self.edit_user(id_value, opts)
    user = User.find_by_id(id_value)
    return '' if opts.values.all?('') || user.class != User

    opts.each_pair do |key, value|
      user.update(key => value) unless value.empty?
    end
    user
  end
end
