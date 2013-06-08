#   Class SqlServer
#   Defines methods for opening, querrying and closing a MSSql DB
#   Created 12/28/07 - Andrew Muller
#   Methods:    open(dbname) - accepts db name on server and opens db
#                   query(sql) - accepts sql query and querries db
#                   close - closes current connection
class SqlServer
  attr_accessor :connection, :data, :fields
  def initialize
    @connection = nil
    @data = nil
  end
  def open (dbname,userID,password,serverName)
    connection_string= "Provider=SQLOLEDB.1;"
    connection_string<<"Persist Security Info = False;"
    connection_string<<"User ID = #{userID};"
    connection_string<<"Password=#{password};"
    connection_string<<"Initial Catalog=#{dbname};"
    connection_string<<"Data Source=#{serverName};"
    connection_string<<"Network Library=dbmssocn"
    @connection = WIN32OLE.new('ADODB.Connection')
    @connection.CommandTimeout = 200
    @connection.ConnectionTimeout = 200
    @connection.Open(connection_string)
  end
  
  def query(sql)
    recordset = WIN32OLE.new('ADODB.Recordset')
    recordset.Open(sql, @connection)
    @fields = []
    recordset.Fields.each do |field|
      @fields << field.Name
    end
    
    begin
      recordset.MoveFirst
      @data = recordset.GetRows 
    rescue
      @data = []
    end
    
    recordset.Close
    @data = @data.transpose
  end
  def close
    @connection.Close
  end
end

#db = SqlServer.new
#db.open(*addarguments*)
#db.query("Select * from v_sch_mgi_2 where sch_date >= '2007/12/01' and sch_date < '2007/12/03'")
#field_names = db.fields
#dbdata = db.data
#field_names.each do |name|
#  print name
#  print ', '
#end
#puts
#dbdata.each do |dt|
#  print dt
#  print ', '
#end

#db.close