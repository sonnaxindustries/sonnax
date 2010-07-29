require File.expand_path(File.dirname(__FILE__) + '/../helper')

module Helper::Array
  def to_conditions
    condition_statements  = self.inject([]) { |arr,val| arr << val[0]; arr }
    condition_values      = self.inject([]) { |arr,val| arr << val[1]; arr }.compact
    
    statement = [condition_statements.join(' AND ')]
    condition_values.inject(statement) { |arr,val| arr << val; arr }
  end
end