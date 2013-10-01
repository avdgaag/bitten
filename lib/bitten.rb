require 'bitten/version'

module Bitten
  # Lower-case string values that should be considered truthy. This allows us
  # to handle both actual `true` and `false` values as well as truthy string
  # values coming from HTML forms.
  TRUE_VALUES = %w[true 1 t].freeze

  # Define the different flags to be stored in the host model's `bits` column.
  # Every flag given gets its own query method (e.g. `published?`) and setter
  # method (e.g. `published=`). All flags are stored in a single integer column
  # in the host object.
  #
  # Note that you can add more flags to the model if you want. If you do, it
  # will default to false unless explicitly set otherwise. Do make sure to only
  # add new flags to the end of the list, as order is vitally important.
  #
  # Note: this assumes the host object defines `bits` and `bits=`, with a
  # default value of `0`. This does not have to be an ActiveRecord attribute,
  # any `attr_accessor` will do, as longs as the default value is set.
  #
  # To use the convenience scopes, the host object has to be an ActiveRecord
  # object in order to define the class-level `scope` method. To disable these,
  # pass the `scopes: false` option.
  #
  # @example Basic usage
  #   ActiveRecord::Migration.create_table do |t|
  #     t.integer :bits, null: false, default: 0
  #   end
  #
  #   class User < ActiveRecord::Base
  #     include Bitten
  #     has_bits :editor, :author, :reviewer
  #   end
  #
  #   user = User.new editor: true
  #   user.editor? # => true
  #   user.author? # => false
  #   user.reviewer? # => false
  #   user.author = true
  #   user.author? # => true
  #   user.save
  #   User.author # => [user]
  #   User.editor # => [user]
  #   User.reviewer # => []
  #   User.not_reviewer # => [user]
  #
  # @example Provide options
  #   class User < ActiveRecord::Base
  #     include Bitten
  #     has_bits :admin, :manager, scopes: false
  #   end
  def has_bits(*flags)
    options = flags.last.is_a?(Hash) ? flags.pop : {}
    options = { scopes: true, column: 'bits' }.merge(options)

    if options[:scopes]
      flags.each_with_index do |flag, index|
        define_scopes flag, options[:column], 1 << index
      end
    end

    mod = Module.new do
      define_method :bitten_bits do
        send options[:column]
      end

      define_method :bitten_bits= do |val|
        send :"#{options[:column]}=", val
      end

      flags.each_with_index do |flag, index|
        bit = 1 << index

        define_method :"#{flag}?" do
          bitten_bits & bit != 0
        end

        define_method :"#{flag}=" do |value|
          if TRUE_VALUES.include? value.to_s.downcase
            self.bitten_bits |= bit
          else
            self.bitten_bits &= ~bit
          end
        end
      end
    end

    include mod
  end

  private

  def define_scopes(flag, column, bit)
    scope flag,           -> { where(['(?.? & ?) != 0', table_name, column, bit]) }
    scope :"not_#{flag}", -> { where(['(?.? & ?) = 0',  table_name, column, bit]) }
  end
end
