# frozen_string_literal: true

class Table
  module Faker
    extend ActiveSupport::Concern

    def build_random_record
      record = to_ar_model.new
      columns.each { |column| column.assign_random_value(record) }
      record
    end

    def create_random_record
      record = build_random_record
      record.save rescue PG::NotNullViolation
      record
    end

    def batch_create_random_record(batch_size = 10, disable_logger: false)
      model = to_ar_model

      old_logger = nil
      if disable_logger
        old_logger = ActiveRecord::Base.logger
        ActiveRecord::Base.logger = nil
      end

      i = 0
      while i < batch_size
        record = model.new
        columns.each { |column| column.assign_random_value(record) }
        record.save

        i += 1
      end

      if disable_logger && old_logger
        ActiveRecord::Base.logger = old_logger
      end

      batch_size
    end


    module ClassMethods
      COLUMN_TYPES_FOR_FAKE = Columns.user_creatable_types - [Columns::ForeignKey]

      def create_random_for(
        project,
        column_classes = COLUMN_TYPES_FOR_FAKE
      )
        transaction do
          random_suffix = SecureRandom.hex(2)
          record = project.tables.create! key:  "table_#{random_suffix}",
                                          name: "Random table #{random_suffix}"
          column_classes.each do |klass|
            random_column_suffix = SecureRandom.hex(2)
            record.columns.create! key: "column_#{random_column_suffix}",
                                   name: "Random Column #{random_column_suffix}",
                                   type: klass.to_s
          end
          record
        end
      end
    end
  end
end
