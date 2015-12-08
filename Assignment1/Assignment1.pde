ArrayList <airPollution> BPollution = new ArrayList <airPollution>(); //Making arraylist
ArrayList fallingChars;

PImage img;

void setup()
{
  size(800, 800);
  fallingChars = new ArrayList();  // Create an empty ArrayList
  img = loadImage("MC1.jpg");
  loadData();
}//end setup

void CreateChar(int n)
{
  int x = (int)random(width);
  int y = (int)random(height/ n);
  fallingChars.add(new fallingStar(x, -y));  // Start by adding some elements
}

void draw()
{
  //println(mouseX, mouseY);
  menu();
}
int mode;

// ----- LOADING DATA ----- //
void loadData()
{
  String[] data = loadStrings("BeijingAprilData.csv"); //loading data from external file

  for (int i = 1; i< data.length; i++)
  {
    airPollution temp = new airPollution(data[i]);  
    BPollution.add(temp); //adds temp variables to arrayList

    //println (BPollution.size() );
    //println (data[i]);
  }//end for()
}//end loadData() method

// ----- MENU -----/
void menu()
{
  background (0);
  
  switch(mode)
  {
  case 0: // menu option
    {
      background (0);
      image(img, 0, 0);
      image(img, 0, 0, width, height);
      
      for (int i = fallingChars.size ()-1; i >= 0; i--)
  {   
    // An ArrayList doesn't know what it is storing so we have to cast the object coming out
    fallingStar fc = (fallingStar) fallingChars.get(i);

    fc.fall();
    fc.display();
  }

  int x = (int)random(4);
  for (int j = 0; j < x; j++)
  {
    CreateChar(4);  // top 1/4th
    CreateChar(8);  // top 1/8th
  }
      

      textAlign(CENTER);
      stroke(0);
      textSize(50);
      fill (255, 0 , 0);
      text(" Menu ", width/2, height/2 - 100);
      textSize(20);
      fill(0, 255, 0);
      text(" Press 0 for the menu", width/2, height/2 - 50);
      text(" Press 1 for the Trend Graph", width/2, height/2);
      text(" Press 2 for the Donut Graph", width/2, height/2 + 50);
      text(" Press 3 for the Smog Graph", width/2, height/2 + 100);
      break;
    }
  case 1:
    {
      drawLineGraph();
      break;
    }

  case 2:
    {
      donut();
      break;
    }

  case 3:
    {
      smog();
      break;
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

  // DRAWING THE LINE GRAPH //
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

  float tinyline = map(1, 0, 29, 0, width-(2*border) );
  for ( int i =0; i< 30; ++i)
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
  line(border, border, border, height - border);

  for (float i = 0; i <= verticalIntervals; i ++)
  {
    float y = map(i, 0, verticalIntervals, height - border, border);
    line(border - tickSize, y, border, y);
    float hAxisLabel = map(i, 0, verticalIntervals, 0, 168.04167);

    textAlign(RIGHT, CENTER);
    text(hAxisLabel, border - (tickSize * 2.0f), y);
  }// end for()
  text(dataRange, border - (tickSize * 2.0f), border);
  line(border - tickSize, border, border, border);

  // Displaying exact value
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
  }// end if()
}//end drawLineGraph() method

// ----- 2nd GRAPH -----//

void smog()
{
  background (125);

  // Draw cloud
  stroke (255);
  fill(255);
  ellipse(width/5, 0, 400, 300);
  ellipse(width/2, 0, 400, 350);
  ellipse (width/1.2, 0, 350, 300);



  // Draw beaker
  /*int x = 15;
   int y = 760;
   int z = width;
   
   line (x, y, x +
   */
}

void donut()
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

//drawing donut chart
  float thetaPrev = 0;
  float cx = height/2;
  float cy = width/2;
  float radius = 150;
  float angle = 0;
  for (int i = 0; i < average.length; i ++)
  {
    airPollution temp = BPollution.get(i);
    fill (temp.colour);
    //fill(random(255), random(255), random(255) );
    //println(average[i]);
    float theta = map(average[i], 0, sum, 0, TWO_PI);
    //textAlign(CENTER);
    arc(cx, cy, radius*2, radius*2, angle, angle+theta);
    //fill(167);
    float x = cx + sin(angle+PI/2)*(radius + 15);
    float y = cy - cos(angle+PI/2)*(radius + 15);
    //text(i, x, y);
    angle+=theta;
    
  }//end for loop
  
  fill (255);
  ellipse (cx, cy, 150, 150);
  
}// end donut() method

// ----- MENU -----//
void keyPressed()
{
  if (key >= '0' && key <='3')
  {
    mode = key - '0';
  }
  println(mode);
}