//Making arraylist
ArrayList <airPollution> BPollution = new ArrayList <airPollution>();

void setup()
{
  size(800, 800);
  loadData();
  
}//end setup

void draw()
{
  menu();
  //drawLineGraph();
  
}
int mode;
          // ----- LOADING DATA ----- //
void loadData()
{
  String[] data = loadStrings("BeijingAprilData.csv");

  for (int i = 1; i< data.length; i++)
  {
    airPollution temp = new airPollution(data[i]);

    //adds temp variables to arrayList
    BPollution.add(temp);

    //println (data[i]);
  }//end for()
}//end loadData() method

void menu()
{
  
  background (255);
  switch(mode)
  {
    case 0:
    background (0);
    
    textAlign(LEFT);
    text(" Menu ", 20,40);
    break;
    
    case 1:
    {
      drawLineGraph();
      break;
    }
    
    case 2:
    {
      
    }
  }
}

        // ----- DRAWING TREND GRAPH ----- //
void drawLineGraph()
{

        // Calculating average for the day //
  float sum = 0;
  float[] average = new float[30]; //float array
  int k=0;
  for (int i = 0; i < BPollution.size(); i += 24, k++)
  {
    sum = 0;
    for (int j = i; j <= i + 23; j ++)
    {
      sum += BPollution.get(j).value;
    }//end for()
    average[k] = sum/24;

    println (average[k]);
  }//end outer for()

          //Draw lineGraph
  background(0);
  float border = width * 0.1f;
  // Print the text 
  textAlign(CENTER, CENTER);   
  float textY = (border * 0.5f); 
  text("Air Pollution in Beijing for April 2015", width * 0.5f, textY);



        //drawAxis(average, 10, 10, 1200, border);   
  float windowRange = (width - (border * 2.0f));
  float dataRange = 168.04167;     

  float verticalIntervals = dataRange/10;//map(1, 23.375, 168.04167, 0, height - (height * 0.2f));
  
  //drawing the graph
  stroke(0, 255, 255);
  for (int i = 1; i < average.length; i ++)
  {
    float x1 = map(i - 1, 0, average.length, border, border + windowRange);
    float x2 = map(i, 0, average.length, border, border + windowRange);
    float y1 = map(average[i - 1], 0, dataRange, height - border, (height - border) - windowRange);
    float y2 = map(average[i], 0, dataRange, height - border, (height - border) - windowRange);
    line(x1, y1, x2, y2);
  }//end for()
  
  //drawing horizontal axis
  line(border, height - border, width - border, height - border);

  float tickSize = border * 0.1f;

  float tinyline = map(1,0, 29, 0, width-(2*border) );
  for( int i =0; i< 30; ++i)
  {
    line(border + (i*tinyline), height-border, border + (i*tinyline), height- (border-10) ); 
    text (i + 1, border + (i*tinyline), height-border + 30);
  }//end for()

  // Draw the vertical axis
 /* line(border, border, border, height - border);
  int num = 0;
  for (int i = 0; i <= verticalIntervals; i ++ , num += 10)
  {
    float y = map(i, 0, verticalIntervals, height - border, border);
    line(border - tickSize, y, border, y);
    text (num, border - 40, y);
  }//end for()*/
  line(border, border , border, height - border);
  
  for (float i = 0 ; i <= verticalIntervals; i ++)
  {
    float y = map(i, 0, verticalIntervals, height - border,  border);
    line(border - tickSize, y, border, y);
    float hAxisLabel = map(i, 0, verticalIntervals, 0, 168.04167);
    
    textAlign(RIGHT, CENTER);
    text(hAxisLabel, border - (tickSize * 2.0f), y);
  } 
    text(dataRange, border - (tickSize * 2.0f), border);
    line(border - tickSize, border, border, border);
    
    //exact amount
    if (mouseX >= border && mouseX <= width - border)
    {
      stroke(255, 0, 0);
      fill(255, 0, 0);
      
      int i = (int) map(mouseX, border, width - border, 0, average.length - 1);
      println("i = " + i);
      float y = map(average[i], 0, dataRange, height - border, border);
      float x1 = map(i, 0, average.length, border, border + windowRange);
      ellipse(x1, y, 5, 5);
      line(x1, border, x1, height - border);
      fill(255);
      textAlign(LEFT);
      text("Value: " + average[i], x1 + 10, y);
      //text("GDP (Mill$): " + data.get(i).amount, mouseX + 10, y + 10);
    }
}//end drawLineGraph() method

void keyPressed()
{
  if (key >= '0' && key <='3')
  {
    mode = key - '0';
  }
  println(mode);
}