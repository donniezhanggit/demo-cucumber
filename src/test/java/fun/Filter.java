package fun;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

public class Filter {

	public static Map<String, String> values = new HashMap<String, String>();
	
	private String tokenName = "access_token=";
	/**
	 * �滻�ַ����е�{xx}Ϊ����
	 * @param value ׼���滻�������ַ���
	 * @return �滻����ַ���
	 */
	public String filterValue(String value) {
		if(value.contains("{open_url}")){
			if(!value.contains("?")){
				value += "?" + tokenName + values.get("{jobrpc_token}");
			}else{
				value += "&" + tokenName + values.get("{jobrpc_token}");
			}
		}
		Map<String, String> vars = new HashMap<String, String>();
		vars.putAll(values);
		for(Entry<String, String> entry : vars.entrySet()){
			if (value.contains(entry.getKey())) {
				value = value.replace(entry.getKey(), entry.getValue());
			}
		}
		value = value.replaceAll("'", "\"");
		return value;
	}
	

	public static class WXFilter{

		private static List<String> errs = new ArrayList<String>();
		private static HashMap<String, String> parentSunControl = new HashMap<String, String>();
		
		/**
		 * ��Ҫ���Խӿڱ�����url�����
		 * @param err
		 */
		public static void addErrs(String err) {
			errs.add(err);
		}
		
		/**
		 * ����ǰ�ýӿںͼ��ӿڵĶ�Ӧ��ϵ(�ӿڿ�ֻд·��   ������?ǰ)
		 * @param parent ǰ�ýӿ�
		 * @param sun	����ӿ�  ����� , �ָ�
		 */
		public static void setControl(String parent, String sun){
			parentSunControl.put(parent, sun);
		}
		
		/**
		 * �ж�ǰ�ýӿ��Ƿ�ʧ��
		 * @param url ��Ҫ����url
		 * @return true��false
		 */
		public static boolean parentHasErr(String url){
			String qian = null;
			Set<Entry<String, String>>  entrys = parentSunControl.entrySet();
			for(Entry<?, ?> entry:entrys){
				String suns[] = entry.getValue().toString().split(",");
				int index = 0;
				for(int i=0; i<suns.length; i++){
					if(url.contains(suns[index])){
						qian = entry.getKey().toString();
						break;
					}
				}
			}
			for(String err:errs){
				if(qian != null && err.contains(qian)){
					return true;
				}
			}
			return false;
		}
	}
	
}
