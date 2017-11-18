import processing.sound.*;
import java.util.*;

public enum Playmode
{
   Chord, Arpeggio 
}

public enum ScaleType
{
  Major(new int[]{0, 2, 2, 1, 2, 2, 2, 1}),
  Minor_Natural(new int[]{0, 2, 1, 2, 2, 1, 2 , 2}),
  Minor_Harmonic(new int[]{0, 2, 1, 2, 2, 1, 3 , 1});
  
  private int[] rootOffset;
  private ScaleType(int[] rootOffset) {this.rootOffset = rootOffset;}
  
  public int[] GetRootOffset() {return rootOffset;}
}
public enum ScaleName
{
  C(60),
  D(62),
  E(64),
  F(65),
  G(66),
  A(68),
  B(70);
  
  
  private int value;
  private ScaleName(int value) {this.value = value; }
  
  public int GetValue() {return value;}
}

public class Scale
{
  protected ScaleName scale;
  protected ScaleType type;
  
  protected int rootKey;
  protected int onctavesUpDown;
  
  protected List<Integer> keys;
  
  public Scale(ScaleName name, ScaleType type)
  {
    this.scale = name;
    this.type = type;
    this.onctavesUpDown = 0;
    
    rootKey = name.GetValue();
    
    InitializeScale();
  }
  
  public Scale(ScaleName name, ScaleType type, int onctavesUpDown)
  {
    this.scale = name;
    this.type = type;
    this.onctavesUpDown = onctavesUpDown;
    
    rootKey = name.GetValue();
    
    InitializeScale();
  }
  
  
  private void InitializeScale()
  {
      if(keys == null) keys = new ArrayList<Integer>();  //<>//
      else keys.clear();
      
      int iterator = 0;
      for(int  i = 0; i < type.GetRootOffset().length; i++)
      {
          iterator += type.GetRootOffset()[i];
          keys.add(rootKey + (iterator + 12 * onctavesUpDown));
      }
  }
  
  public Integer[] GetScale()
  {
      return(keys.toArray(new Integer[keys.size()]));
  }
  public Integer[] MakeChord(int[] chordKeys)
  {
      boolean appropriateKeys = true;
      for(int i = 0; i < chordKeys.length; i++)
      {
         if(chordKeys[i] < 0 || chordKeys[i] > 7)
         {
            appropriateKeys = false;
            break;
         }
      }
      
      if(!appropriateKeys) return new Integer[]{};
      
      List<Integer> chord = new ArrayList<Integer>();
      for (int i = 0; i < chordKeys.length; i++)
      {
         chord.add(keys.get(chordKeys[i] - 1));
      }
      
      return(chord.toArray(new Integer[chord.size()]));
  }
  
};

public class PlayerConfig
{
    public float attackTime;
    public float sustainTime;
    public float sustainLevel;
    public float releaseTime;
    public float amplitude;
    
    public PlayerConfig(float attackTime, float sustainTime, float sustainLevel, float releaseTime, float amplitude)
    {
       this.amplitude = amplitude;
       this.releaseTime = releaseTime;
       this.sustainLevel = sustainLevel;
       this.sustainTime = sustainTime;
       this.attackTime = attackTime;
    }
};

public abstract class NotePlayer
{
    protected TriOsc oscilator;
    protected Env enveloper;
    protected PlayerConfig config;
    
    protected int octaveModifier = 0;
    
    protected Integer[] keys;

    public NotePlayer(TriOsc oscilator, Env enveloper, PlayerConfig config)
    {
        this.oscilator = oscilator;
        this.enveloper = enveloper;
        this.config = config;
        
        this.octaveModifier = 0;
    }
    public NotePlayer(TriOsc oscilator, Env enveloper, PlayerConfig config, int octaveModifier)
    {
        this(oscilator, enveloper, config);
        this.octaveModifier = octaveModifier;
    }
    
    public void SetKeys(Integer[] keys)
    {
       this.keys = keys; 
    }
    public void SetupNotes(Integer[] notes)
    {
        keys = notes;
    }
    
    public abstract void Play();
    
    protected float MIDItoFrequency(int note)
    {
      return (pow(2, ((note-69)/12.0)))*440;
    }
};


public class ChordPlayer extends NotePlayer
{
    public ChordPlayer(TriOsc oscilator, Env enveloper, PlayerConfig config)
    {
        super(oscilator, enveloper, config);
    }
    
    public void Play()
    {
        for(int i = 0; i < keys.length; i++)
        {
            oscilator.play(MIDItoFrequency(keys[i]), config.amplitude); 
            enveloper.play(oscilator, config.attackTime, config.sustainTime, config.sustainLevel, config.releaseTime);
        }
    }
};

public class ArpeggioPlayer extends NotePlayer
{
    protected int currentNote = 0;

    public ArpeggioPlayer(TriOsc oscilator, Env enveloper, PlayerConfig config)
    {
        super(oscilator, enveloper, config);
    }

    public void Play()
    {
        oscilator.play(MIDItoFrequency(keys[currentNote]), config.amplitude); 
        enveloper.play(oscilator, config.attackTime, config.sustainTime, config.sustainLevel, config.releaseTime);
                
        currentNote++;
                
        if(currentNote >= keys.length)
            currentNote = 0;
    }
    
    public void Reset()
    {
       currentNote = 0;
    }
};


        //this.playmode = playmode;
        //this.arpeggioInterval = 500;
        //this.loopInterval = 1000;
        //this.looping = false;
        
        //this.playTime = 0;

/**
 * Processing Sound Library, Example 2
 * 
 * This sketch shows how to use envelopes and oscillators. 
 * Envelopes describe to course of amplitude over time. 
 * The Sound library provides an ASR envelope which stands for 
 * attack, sustain, release. 
 * 
 *       .________
 *      .          ---
 *     .              --- 
 *    .                  ---
 *    A       S        R 
 */