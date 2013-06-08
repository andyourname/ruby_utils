class ExcelSheet
  attr_writer :sheet, :range
  attr_reader :sheet, :range
  def initialize (xlFile)
    @file = xlFile
  end
  def openFile
    @xl = WIN32OLE.new('Excel.Application')
    @book = @xl.Workbooks.Open(@file)
  end
  def openSheet(sheet)
    @worksheet = @book.Worksheets(sheet)
  end
  def openRange(range)
    @currentRange = @worksheet.Range(range)
  end
  def closeFile
    @book.Save
    @book.Close
    @xl.Quit()
  end
end

#############################################
require 'win32ole'
excel = ExcelSheet.new('c:\scripts\Test.xls')
excel.openFile
#begin
  excel.sheet = 'sheet1'
  sheet = excel.openSheet(excel.sheet)
  excel.range = 'TestRange'
  range = excel.openRange(excel.range)
  range.Value = 'TESTING'
  excel.sheet = 'sheet2'
  excel.range = 'TestRange2'
  sheet = excel.openSheet(excel.sheet)
  range = excel.openRange(excel.range)
  range.Value = 'Testing2'
#rescue
  excel.closeFile
#end
####################################