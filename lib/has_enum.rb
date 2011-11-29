require "has_enum/version"
require "renum"

module HasEnum
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods

     # Use like this
     #
     #   class Furniture
     #     has_enum :colors, :column_name => :custom_color_type
     #   end
    def has_enum(enum_name, options={})
      
      enum_column = options.has_key?(:column_name) ? options[:column_name].to_s : "#{enum_name}_type"

      self.send("validate", "#{enum_column}_check_for_valid_type_of_enum")
      
      # throws a NameError if Enum Class doesn't exists
      enum_class = options.has_key?(:class_name) ? options[:class_name].to_s.constantize : enum_name.to_s.camelize.constantize

      # Enum must be a Renum::EnumeratedValue Enum
      raise ArgumentError, "expected Renum::EnumeratedValue" unless enum_class.superclass == Renum::EnumeratedValue
      
      define_method("reset_enum_changed") do
        @enum_changed = false
      end
      after_save :reset_enum_changed

      define_method("#{enum_name}") do
        begin
          return self[enum_column].present? ? enum_class.const_get(self[enum_column]) : nil
        rescue NameError => e
          return nil
        end
      end
      
      define_method("#{enum_column}=") do |enum_literal|
        unless enum_literal == self[enum_column]
          self[enum_column] = enum_literal
          @enum_changed = true
        end
      end

      define_method("#{enum_name}=") do |enum_to_set|
        old_value = self[enum_column]
        enum_resolved = enum_class[enum_to_set]
        if enum_to_set.nil?
          self[enum_column] = nil
        elsif enum_resolved
          self[enum_column] = enum_resolved.name
        else
          raise ArgumentError, "could not resolve #{enum_to_set}"
        end
        @enum_changed ||= self[enum_column] != old_value
      end

      define_method("#{enum_name}_has_changed?") do
        !!@enum_changed
      end
      
      define_method("#{enum_column}_check_for_valid_type_of_enum") do
        return true if self[enum_column].nil? || self[enum_column].to_s.empty?
        begin
          enum_class.const_get(self[enum_column])
        rescue NameError => e
          self.errors.add(enum_column.to_sym, "Wrong type '#{self[enum_column]}' for enum '#{enum_name}'")
          return false
        end
        return true
      end
    end

  end
end
