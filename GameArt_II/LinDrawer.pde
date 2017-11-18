class LineDrawer
{  
  private int barWidth = 20;
  private int lastBar = -1; 
  
  public LineDrawer(int barWidth)
  {
    this.barWidth = barWidth;
    
    Setup();
  }
  
  
  public void Setup()
  {
    //Switch color mode from RGB to HSV
    colorMode(HSB, height, height, height);
    
    //Sets the current draw mode to noStroke (so we wont have outline)
    noStroke();
    
    //Sets background color to black
    background(0);  
  }
  
  public void Draw()
  {
    //height = window height
    
    int whichBar = mouseX / barWidth;
    if (whichBar != lastBar)
    {
      int currentBar = whichBar * barWidth;
      fill(mouseY, height, height);
      rect(currentBar, 0, barWidth, height);
      lastBar = whichBar;
    }
  }
  
};