require 'rubygems'
require 'roo'
require 'ostruct'

class Import::Excel::Publication
  attr_accessor :file_name, :start_row, :start_column
  
  def initialize
    self.file_name = '/users/nateklaiber/downloads/publication_data.xls'
  end
  
  def workbook
    @workbook ||= Excel.new(self.file_name)
  end
  
  def start_column
    2
  end
  
  def start_row
    3
  end
  
  def publications_worksheet
    @publications_worksheet ||= self.workbook.sheets[2]
  end
end


# 
# file_name = 
# workbook = Excel.new(file_name)
# start_row = 3
# start_column = 2
# 
# workbook.default_sheet = workbook.sheets[2]
# 
# # iterate over the rows
# # import all of the uniques
# records = []
# (start_row..workbook.last_row).each_with_index do |index,row|
#   records << OpenStruct.new(:title_id => workbook.cell(index, 2),
#                            :publication_category => workbook.cell(index, 3),
#                            :publication_type => workbook.cell(index, 4),
#                            :title => workbook.cell(index, 5),
#                            :subject => workbook.cell(index, 6),
#                            :date => workbook.cell(index, 7),
#                            :author => workbook.cell(index, 8),
#                            :pdf => workbook.cell(index, 9),
#                            :product_line_id => workbook.cell(index, 10),
#                            :make => workbook.cell(index, 11),
#                            :unit => workbook.cell(index, 12),
#                            :keywords => OpenStruct.new(:rebuilding => workbook.cell(index, 13),
#                                                        :diagnosis => workbook.cell(index, 14),
#                                                        :complaint => workbook.cell(index, 15),
#                                                        :correction => workbook.cell(index, 16)
#                           )
#             )
# end