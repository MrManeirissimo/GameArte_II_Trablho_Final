public interface Action
{
  public void run();
};

public static class UserInput
{
  protected static HashMap<Character,List<Action>> actions;
  protected static char[] keySet;
  protected static char key;  
  
  public static void AddListener(char c, Action action)
  {
      List<Action> selectedKeyActions = actions.get(c); 
      if(selectedKeyActions != null)
      {
          actions.get(c).add(action);
      }
  }
  
  public static void Initialize(char[] keySet)
  {
     actions = new HashMap<Character, List<Action>>();
      UserInput.keySet = keySet;
      
      for(int i = 0; i < UserInput.keySet.length; i++)
      {
        actions.put(keySet[i], new ArrayList<Action>());
      }
  }
  
  public static void TriggerKey(char _key)
  {
      List<Action> actionsToTrigger = actions.get(_key);
      if(actionsToTrigger != null)
      {
          for(Action action : actionsToTrigger)
          {
             action.run(); 
          }
      }
  }
};