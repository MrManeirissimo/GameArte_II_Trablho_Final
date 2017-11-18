import processing.sound.*;

TriOsc oscilator;
Env enveloper;

PlayerConfig pConfig;
NotePlayer nPlayer;

Integer[] notes;
Integer[] chord;

//----------------------- Chord Definition -------------------

Scale cMajor;  Scale cMinorN;  Scale cMinorH;
Scale dMajor;  Scale dMinorN;  Scale dMinorH;
Scale eMajor;  Scale eMinorN;  Scale eMinorH;
Scale fMajor;  Scale fMinorN;  Scale fMinorH;
Scale gMajor;  Scale gMinorN;  Scale gMinorH;
Scale aMajor;  Scale aMinorN;  Scale aMinorH;
Scale bMajor;  Scale bMinorN;  Scale bMinorH;

//----------------------- Chord Definition -------------------

//--------------------- Chord Initialization -----------------

public void SetupChords()
{
    cMajor = new Scale(ScaleName.C, ScaleType.Major, 0);
    dMajor = new Scale(ScaleName.D, ScaleType.Major, 0);
    eMajor = new Scale(ScaleName.E, ScaleType.Major, 0);
    fMajor = new Scale(ScaleName.F, ScaleType.Major, 0);
    gMajor = new Scale(ScaleName.G, ScaleType.Major, 0);
    aMajor = new Scale(ScaleName.A, ScaleType.Major, 0);
    bMajor = new Scale(ScaleName.B, ScaleType.Major, 0);
}

//--------------------- Chord Initialization -----------------
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

void setup()
{  
  size(800, 600);
  background(255);

  //Defines a scale
  SetupChords();
  
  //All notes from the scale
  notes = cMajor.GetScale();
  
  //Triad
  chord = cMajor.MakeChord(new int[]{1,3,5});  
  
  oscilator = new TriOsc(this);
  enveloper = new Env(this);
  
  pConfig = new PlayerConfig(0.001f, 0.04f, 0.4f, 0.2f, 0.8f);
  nPlayer = new ArpeggioPlayer(oscilator, enveloper, pConfig);
  
  nPlayer.SetupNotes(chord);
  
  UserInput.Initialize(new char[]{'a', 'w', 's'});
  UserInput.AddListener('a', new ChangePlayerNotes(nPlayer, cMajor.MakeChord(new int[]{1,3,5})));
  UserInput.AddListener('s', new ChangePlayerNotes(nPlayer, dMajor.MakeChord(new int[]{1,3,5})));
  //UserInput.AddListener('a', new SayHi());
}

int loopTime = 250;
int currentTime = 0;
void draw()
{ 
  if(millis() >= currentTime)
  {
     nPlayer.Play();
     
     currentTime = millis() + loopTime;
  }
}
void keyPressed()
{
    UserInput.TriggerKey(key);
}