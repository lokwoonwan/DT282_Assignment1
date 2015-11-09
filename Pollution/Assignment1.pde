//Making a table
Table AirPollution;

void setup()
{
  size(500, 500);
  loadData();
}

void loadData()
{
   //variable to show size of tables
  int SIZE = 0;
  
  //Load data from table
  AirPollution = loadTable("BeijingAprilData.csv", "header");
  SIZE = AirPollution.getRowCount(); //how many rows
  
  println(SIZE + " total rows in table"); 

  for (TableRow row : AirPollution.rows()) 
  {
    String location = row.getString("Site");
    int year = row.getInt("Year");
    int month = row.getInt("Month");
    int day = row.getInt("Day");
    int hour = row.getInt("Hour");
    int value = row.getInt("Value");
    String unit = row.getString("Unit");
    
    println("Air pollution in " + location + " on " + day + " " + month + " " + year + " is " + value +unit);
  }//end for each
  
  /*String[] lines = loadStrings("");
  
  for(Integer line:line)
  {
    println(s);
    int line = line.split(",");
    
    ArrayList<Integer> lineData = new ArrayList<Integer>();
    
    // Start at 1, so we skip the first one 
    for (int i = 1 ; i < line.length ; i ++)
    {
      lineData.add(Integer.parseInteger(line[i]));              
    }
    data.add(lineData);
  } */
}
