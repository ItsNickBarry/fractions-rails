class UseCaseInsensitiveIndexes < ActiveRecord::Migration
  def change
    [Fraction, Character].each do |model|
      remove_index model.table_name, name: "index_#{model.table_name}_on_name"
      model.connection.execute(<<-SQL)
        CREATE UNIQUE INDEX index_#{model.table_name}_on_name
          ON #{model.table_name} (name COLLATE nocase)
      SQL
    end

    [Position, Electorate, Region].each do |model|
      remove_index model.table_name, name: "index_#{model.table_name}_on_name_and_fraction_id"
      model.connection.execute(<<-SQL)
        CREATE UNIQUE INDEX index_#{model.table_name}_on_name_and_fraction_id
          ON #{model.table_name} (name COLLATE nocase, fraction_id)
      SQL
    end
  end
end
