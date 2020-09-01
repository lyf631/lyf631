package com.oracle.gdms.util;

import java.util.ResourceBundle;

import com.oracle.gdms.service.AreaService;

public class Factory {
	
	private static ResourceBundle rb;  //����һ������Դ����
	static {
		rb = ResourceBundle.getBundle("config/application");
	}
	
	private Factory() {}
	
	private static Factory provl;

	public static Factory getInsatnce() {
		provl = provl == null ? new Factory() : provl;
		return provl;
	}

	public Object getObject(String key) {
		//��ȡ�����ļ����������ļ����ҵ�key��Ӧ��class·��������
		String classname = rb.getString(key);
		Object o = null;
		try {
			o = Class.forName(classname).newInstance();
		} catch (InstantiationException e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		}
		return o;
	}


}
