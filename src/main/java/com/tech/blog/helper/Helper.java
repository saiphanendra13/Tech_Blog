package com.tech.blog.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

public class Helper {
	
	public static boolean deleteFile(String path) {
		boolean res=false;
		try {
			File file=new File(path);
			res=file.delete();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return res;
		
	}
	
	public static boolean saveFile(InputStream stream, String path) {
		boolean res=false;
		try {
			byte data[]=new byte[stream.available()];
			
			stream.read(data);
			
			FileOutputStream fos=new FileOutputStream(path);
			
			fos.write(data);
			fos.flush();
			fos.close();
			
			res=true;
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

}
