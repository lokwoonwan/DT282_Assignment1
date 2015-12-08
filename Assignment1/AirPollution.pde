//Loading CSV file
class airPollution
{
  float year;
  float month;
  float day;
  float hour;
  float value;
  color colour;
  
  airPollution(String info) //<--data that's coming in + name of my string
  {
    //splits string into seperate array
    String[] infoSplitter = info.split (",");
    
    //converting string to float and gives value to class variables
    year = Float.parseFloat(infoSplitter[1]);
    month = Float.parseFloat(infoSplitter[2]);
    day = Float.parseFloat(infoSplitter[3]);
    hour = Float.parseFloat(infoSplitter[4]);
    value = Float.parseFloat(infoSplitter[5]);
    colour = color(random(0, 255), random(1, 255), random(0, 255));
    
  }//end constructor
  
}//end class