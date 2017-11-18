public abstract class TimedAction implements Action
{
   public int interval = 0;
   public long currentInterval = 0;
   
   public void Increment()
   {
      currentInterval = millis() + interval;
   }
};

static class EventHandler
{
    protected static List<TimedAction> actions = new ArrayList<TimedAction>();
    
    public static void AddEvent(TimedAction action)
    {
        actions.add(action);
    }
    public static void RemoveEvent(TimedAction action)
    {
       actions.remove(action); 
    }
    public static void Run(int millis)
    {
        for(TimedAction action : actions)
        {
           if(millis >= action.currentInterval)
           {
               action.run();
               action.Increment();
           }
        }
    }
};