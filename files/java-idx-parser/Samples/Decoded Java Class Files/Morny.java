
public class Morny {

   public static String HYurrds(String mhuyi) {
      int dtduuyi = 0;
      mhuyi = (new StringBuffer(mhuyi)).reverse().toString();
      String gerxcx = "";
      mhuyi = mhuyi.replace("a-nytios", "");

      for(int i = 0; i < mhuyi.length(); ++i) {
         ++dtduuyi;
         if(dtduuyi == 3) {
            gerxcx = gerxcx + mhuyi.charAt(i);
            dtduuyi = 0;
         }
      }

      return gerxcx;
   }

   public static String ada(String a) {
      return System.getProperty(a);
   }
}
