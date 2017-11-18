import processing.sound.*;

Enviroment MusicalEnviroment;
Flock EnviromentFlock;

TriOsc oscilator;
Env enveloper;

PlayerConfig pConfig;
NotePlayer nPlayer;


class ChangePlayerNotes implements Action
{
    NotePlayer player;
    Integer[] notes;
    
    public ChangePlayerNotes(NotePlayer player, Integer[] newNotes)
    {
      this.player = player;
      this.notes = newNotes;
    }
    
    public void run()
    {
       player.SetKeys(notes);
    }
};

class ChangeToNextProgression extends TimedAction
{
    protected int currentScale = 0;
    
    protected NotePlayer player;
    protected Scale[] scalesToPlay;
    
    
    public ChangeToNextProgression(NotePlayer player, Scale[] scales, int interval)
    {
        this.player = player;
        this.scalesToPlay = scales;
        this.interval = interval;
        
        currentScale = 1;
        currentTime = millis();
    }
  
    public void run()
    {
        player.SetKeys(scalesToPlay[currentScale].MakeChord(new int[] {1, 3, 5}));
        currentScale++;
        
        if(currentScale >= scalesToPlay.length)
            currentScale = 0;
            
            
        ArpeggioPlayer ap = (ArpeggioPlayer)player;
        if(ap != null)
        {
           ap.Reset(); 
        }
     }
};

void setup()
{  
  size(800, 600);
  colorMode(HSB, width, width, width);
  

  oscilator = new TriOsc(this);
  enveloper = new Env(this);
  
  pConfig = new PlayerConfig(0.001f, 0.04f, 0.4f, 0.2f, 0.8f);
  nPlayer = new ArpeggioPlayer(oscilator, enveloper, pConfig);

  //Defines all chord scales
  SetupChords();
  
  //Defines minor harmonic chord scales
  SetupMinorHarmonicChords();
  
  //Sets up the background player defined in "MusicalDefinition"
  SetupBackgoundPlayer();
  
  //Sets up the boid player defined in "MusicalDefinition"
  SetupBoidPlayer();

  bkg_player.SetupNotes(cMajor.MakeChord(new int[]{1,3,5}));
  boid_player.SetupNotes(cMajor.MakeChord(new int[]{1,3,5}));
  
  UserInput.Initialize(userPiano);
  UserInput.AddListener(C_KEY, new ChangePlayerNotes(bkg_player, cMajor.MakeChord(new int[]{1,3,5})));
  UserInput.AddListener(D_KEY, new ChangePlayerNotes(bkg_player, dMajor.MakeChord(new int[]{1,3,5})));
  
  EventHandler.AddEvent(new ChangeToNextProgression(boid_player, new Scale[] {cMajor, eMinorH, dMinorH, gMajor}, 2000));  
  
  //MusicalEnviroment = new Enviroment();
  //MusicalEnviroment.SetScale(eMajor);
  
  EnviromentFlock = new Flock(MusicalEnviroment);
}

int loopTime = 300;
int currentTime = 0;
void draw()
{ 
  background(50);
  if(millis() >= currentTime)
  {
     //nPlayer.Play();
     //bkg_player.Play();
     boid_player.Play();
     
     currentTime = millis() + loopTime;
  }
  
  EventHandler.Run(millis());
  EnviromentFlock.Run();
}

void mousePressed()
{
    for (int i = 0; i < 10; i++)
    {
        EnviromentFlock.addBoid(new Boid(mouseX,mouseY));
    }
}

void keyPressed()
{
    UserInput.TriggerKey(key);
}