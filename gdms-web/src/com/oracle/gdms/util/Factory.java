package com.oracle.gdms.util;

import java.util.ResourceBundle;

import com.oracle.gdms.service.AreaService;

public class Factory {
	
	private static ResourceBundle rb;  //定义一个绑定资源对象
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
		//读取配置文件，从配置文件中找到key对应的class路径和名称
		String classname = rb.getString(key);
		Object o = null;
		try {
			o = Class.forName(classname).newInstance();
		} catch (InstantiationException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return o;
	}


}
