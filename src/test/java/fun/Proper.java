package fun;

import java.io.*;
import java.util.Properties;

/**
 * Created by hanminggui on 6/2/2016.
 */
public class Proper {

    //�����ļ�Ŀ¼
    private final String source = System.getProperty("user.dir") + "/build/resources/test/";

    /**
     * ��ȡ�����ļ�
     * @param fileName �ļ�����
     * @return  ��ȡ��ɵ�Properties����
     */
    public Properties getProperties(String fileName){
        System.out.println();
        Properties pro = null;
        try {
            InputStream is = new BufferedInputStream(new FileInputStream(source+fileName));
            pro = new Properties();
            pro.load(is);
            is.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return pro;
    }
}
