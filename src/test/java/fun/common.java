package fun;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;

public class common {
	
	/**
	 * ������������ʾ�ȴ�
	 *   �������ȴ�ʱ��
	 *  ����ֵ����
	 */
	public static void waitTime(int t){
		try {
			Thread.sleep(t);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * �����������ж�һ�������Ƿ���һ�����ڶ���
	 *   ������date ���ж�����
	 *       dateBefore С����
	 *       dateAfter  ������
	 *  ����ֵ��booleanֵ��true or false��
	 */
	public static boolean dateCompare(Date date,Date dateBefore,Date dateAfter){
		if(date.before(dateAfter)&&date.after(dateBefore)){
			return true;
		}else{
		return false;
		}
	}
	
	/**
	 * ��������������һ�������
	 *    ������int������
	 *   ����ֵ��С��number��������
	 */
	public static int getRandom(int number) {
		Random rnd = new Random();
		if (number == 1 || number == 0) {
			return number;
		} else {
			int i = rnd.nextInt(number);
			return i;
		}
	}
	
	/**
	 * ������������ȡ������IP��ַ
	 *  ����ֵ������IP��ַ
	 */
	public static String getIp(){
			InetAddress address = null;
			try {
				address = InetAddress.getLocalHost();
			} catch (UnknownHostException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return address.getHostAddress();
	}

	/**
	 * ������������ȡ��ǰϵͳ����
	 *
	 *  ����ֵ����ǰϵͳ����
	 */
	public static String getCurrentDate() {
			Date now = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat(
					"yyyy/MM/dd HH:mm:ss");// ���Է�����޸����ڸ�ʽ
			String currentDate = dateFormat.format(now);
			return currentDate;
	}

	/**
	 * ��������������ǰϵͳ����ת��Ϊ�ַ���
	 *  ����ֵ�� ��ǰϵͳ���ڵ��ַ������磺20140906120500��
	 */
	public  static String getCurrentDateStr() {
			Calendar cal = Calendar.getInstance();
			int y, m, d, h, mi, s;
			String strM = null, strD = null, strH = null, strMi = null, strS = null;
			y = cal.get(Calendar.YEAR);
			m = cal.get(Calendar.MONTH)+1;
			d = cal.get(Calendar.DATE);
			h = cal.get(Calendar.HOUR_OF_DAY);
			mi = cal.get(Calendar.MINUTE);
			s = cal.get(Calendar.SECOND);
			if (m < 10) {
				strM = "0" + String.valueOf(m);
			} else {
				strM = String.valueOf(m);
			}
			if (d < 10) {
				strD = "0" + String.valueOf(d);
			} else {
				strD = String.valueOf(d);
			}
			if (h < 10) {
				strH = "0" + String.valueOf(h);
			} else {
				strH = String.valueOf(h);
			}
			if (mi < 10) {
				strMi = "0" + String.valueOf(mi);
			} else {
				strMi = String.valueOf(mi);
			}
			if (s < 10) {
				strS = "0" + String.valueOf(s);
			} else {
				strS = String.valueOf(s);
			}
			String newStr = String.valueOf(y) + strM + strD + strH + strMi + strS;
			return newStr;
	}

	/**
	 * ����������ȥ���ַ����е�"\"
	 *   ������str �ַ���
	 *  ����ֵ��ȥ��"\"���ַ���
	 */
	public static String getStrNoQuot(String str) {
			String newStr = str.replace("\"", "");
			return newStr;
	}
	
	/**
	 * ��������
	 * @param arr
	 * @param begin
	 * @param length
	 * @return
	 */
	public static String[] arrayCopy(String[] arr, int begin, int length){
		String reArray[] = new String[length];
		for(int i=0; i<length; i++){
			reArray[i] = arr[begin++];
		}
		
		return reArray;
	}
	
}
