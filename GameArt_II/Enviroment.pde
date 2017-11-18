public TriOsc osc = new TriOsc(this);

public class Enviroment
{
    protected Scale currentScale;
    protected HashMap<String, NotePlayer> notePlayers;
    
    public Enviroment()
    {
      
    }
    
    public Scale GetScale()
    {
       return(currentScale); 
    }
    public void SetScale(Scale newScale)
    {
        currentScale = newScale;
    }
    
    
    public void AddPlayer(String playerName, NotePlayer player)
    {
        if(notePlayers == null)
            notePlayers = new HashMap<String,NotePlayer>();
        
        notePlayers.put(playerName, player);
    }
    public NotePlayer GetPlayer(String name)
    {
        return notePlayers.get(name);
    }
    
    
    public void ChangeEnviromentColor(color HSBcolor)
    {
        colorMode(HSB, 360, 100,100);
        background(HSBcolor);
    }
};