require_relative 'db_connection'
require_relative '01_sql_object'
require 'byebug'
module Searchable
  def where(params)
    stringed_line = params.keys.map { |key| "#{key} = ?" }.join(" AND ")
    results = DBConnection.execute(<<-SQL,*params.values)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{stringed_line}
      SQL
    parse_all(results)
  end
end

class SQLObject
  extend Searchable
  # Mixin Searchable here...
end
