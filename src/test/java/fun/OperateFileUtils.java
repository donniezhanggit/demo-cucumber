package fun;

import fun.Filter.WXFilter;
import org.apache.commons.io.FileUtils;

import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;




/**
 * �ļ�������
 * 
 * @author zhaokaicheng
 * 
 */
public class OperateFileUtils {
	
	public static String touser = "";
	public static String toparty = "";
	public static String projectAfterName = "";
	
	/**
	 * д�ļ�
	 */
	public static void writeFile(String filePath,String content){
		FileWriter writer = null;
        try {     
            // ��һ��д�ļ��������캯���еĵڶ�������true��ʾ��׷����ʽд�ļ�     
            writer = new FileWriter(filePath, true);
            writer.write(content);
        } catch (IOException e) {     
            e.printStackTrace();     
        } finally {     
            try {     
                if(writer != null){  
                    writer.close();     
                }  
            } catch (IOException e) {     
                e.printStackTrace();     
            }     
        }
	}
	
	public static void writeErrLog(String filePath,String errName, String err_url, String err_type, String err_param, String err_json, String explain){
		writeFile(filePath, errName+"\r\n"+"URL: " + err_url
				+ "\r\n" + "����: " + err_param + "\r\n" + "��������: "
				+ err_type + "\r\n" + "����ֵ: " + err_json + "\r\n"
				+explain+"\r\n"+"\r\n" );
		Pattern pet = Pattern.compile("\\{[\\w]+\\}");
        Matcher match = pet.matcher(err_url+err_param+explain);
        //�ռ��˺��ռ���Ϊ�ա�ǰ�ýӿڱ����ӿڲ��������д���δ�滻�ı���ʱ  ����΢�ű���
        if(match.find() || WXFilter.parentHasErr(err_url) || (0 == touser.length() && 0 == toparty.length())) {
        	return;
        }
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		Map<String, String> map = new HashMap<String, String>();
		//url+param
		map = new HashMap<String, String>();
		map.put("title", "Moblie"+projectAfterName+" url:"+err_url);
		map.put("description", "����:"+err_param);
		map.put("url", err_url+err_param);
		map.put("picurl", "");
		list.add(map);
		//result
		map = new HashMap<String, String>();
		map.put("title", "���ؽ��:"+err_json);
		map.put("description", "");
		map.put("url", err_json);
		map.put("picurl", "");
		list.add(map);
		//err
		map = new HashMap<String, String>();
		map.put("title", errName + "\n" + explain);
		map.put("description", "");
		map.put("url", errName + "\n" + explain);
		map.put("picurl", "");
		list.add(map);
		new Weixin(touser, toparty).sendNews(list);
	}

	/**
	 * ɾ���ļ�
	 * 
	 * @param filePath
	 */
	public static void deleteFile(String filePath) {
		File file = new File(filePath);
		if (file.exists()) {
			if (file.isFile()) {
				file.delete();
			}
		}
	}

	/**
	 * ��ȡcucumber���ɵ�report js�ļ�
	 * 
	 * @param filePath
	 * @return
	 */
	public static Map<Integer, String> readReportJSFile(String filePath) {
		Map<Integer, String> resultMap = new HashMap<Integer, String>();
		File file = new File(filePath);
		BufferedReader reader = null;

		String tempStr = null;
		int i = 0;
		try {
			reader = new BufferedReader(new InputStreamReader(
					new FileInputStream(file), "UTF-8"));
			while ((tempStr = reader.readLine()) != null) {
				if (tempStr.equalsIgnoreCase("\"status\": \"passed\"")
						|| tempStr.equalsIgnoreCase("\"status\": \"failed\",")) {
					resultMap.put(i, tempStr.split("\"")[3]);
					i++;
				}
			}
			reader.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			throw new RuntimeException("report.js�ļ�û���ҵ�!!!");
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (reader != null) {
				try {
					reader.close();
				} catch (IOException e1) {
				}
			}
		}

		return resultMap;
	}

	/**
	 * �޸��ļ���
	 * 
	 * @param newFileName
	 */
	public static void renameFile(String filePath, List<String> newFileName) {
		File file = new File(filePath);
		for(int i = 0; i < newFileName.size(); i++) {
			File new_file = new File(filePath + newFileName.get(i) + ".png");
			file.listFiles()[i].renameTo(new_file);
		}
	}

	/**
	 * ��byte[]ת����File
	 * 
	 * @param b
	 * @param outputFile
	 * @return
	 */
	public static File getFileFromBytes(byte[] b, String outputFile) {
		BufferedOutputStream stream = null;
		File file = null;
		try {
			file = new File(outputFile);
			FileOutputStream fstream = new FileOutputStream(file);
			stream = new BufferedOutputStream(fstream);
			stream.write(b);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (stream != null) {
				try {
					stream.close();
				} catch (IOException e1) {
					e1.printStackTrace();
				}
			}
		}
		return file;
	}

	/**
	 * ��ȡĿ¼����ĳ����׺��β�������ļ�
	 * 
	 * @param filePath
	 * @param data
	 * @return
	 */
	public static List<File> getFile(String filePath, List<File> data,
			String suffixName) {
		File file = new File(filePath);
		if (file.isDirectory()) {
			File[] files = file.listFiles();
			for (int i = 0; i < files.length; i++) {
				data = getFile(files[i].getPath(), data, suffixName);
			}
		} else if (file.getName().endsWith(suffixName)) {
			data.add(file);
		}
		return data;
	}

	/**
	 * �����ļ���ĳ���ļ�����
	 */
	public static void copyFile() {
		// ����ͼ��image���Ƶ�ָ�����ļ�����
		String relativelyPath = System.getProperty("user.dir"); // ��ȡ��Ŀ�ĸ�Ŀ¼
		String src_file_path = relativelyPath + "/build/cucumber";
		List<File> data = new ArrayList<File>();
		data = OperateFileUtils.getFile(src_file_path, data, ".png");
		String new_path = "D:/SeleniumImage";
		File new_file = new File(new_path);
		if (!new_file.isDirectory()) {
			new_file.mkdir();
		}
		for (int i = 0; i < data.size(); i++) {
			File file = new File(new_path + "/" + i + ".png");
			try {
				FileUtils.copyFile(data.get(i), file);
			} catch (IOException e) {
				e.printStackTrace();
				throw new RuntimeException(e);
			}
		}
	}
	
	/**
	 * copyĿ¼
	 * 
	 * @param dirPath
	 * @param newDirPath
	 * @return
	 */
	public static void copyDir(String dirPath, String newDirPath) {
		File dir = new File(dirPath);
		File new_dir = new File(newDirPath);
		if (!new_dir.exists() || new_dir.isFile()) {
			new_dir.mkdir();
		}
		try {
			FileUtils.copyDirectory(dir, new File(newDirPath));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

//	 public static void main(String[] args) {
//		 List<String> list = new ArrayList<String>();
//		 list.add("test01");
//		 renameFile("D:\\SeleniumImage", );
//	 String path =
//	 "D:/Selenium�Զ�������/�Զ�����ƽ̨/sell-platform-online-autoTest/build/cucumber";
//	 List<File> data = new ArrayList<File>();
//	 data = getFile(path, data, ".png");
//	
//	 for(int i = 0; i < data.size(); i++ ) {
//	 System.out.println(data.get(i).getName());
//	 }
//	 String new_path = "D:/SeleniumImage";
//	 File new_file = new File(new_path);
//	 if (!new_file.isDirectory()) {
//	 new_file.mkdir();
//	 }
//	
//	 for (int i = 0; i < data.size(); i++) {
//	 File file = new File(new_path + "/" + i + ".png");
//	 try {
//	 FileUtils.copyFile(data.get(i), file);
//	 } catch (IOException e) {
//	 e.printStackTrace();
//	 throw new RuntimeException(e);
//	 }
//	 }
//	 }
}
