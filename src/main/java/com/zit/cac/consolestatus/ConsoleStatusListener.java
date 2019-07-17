package com.zit.cac.consolestatus;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.sun.org.apache.bcel.internal.generic.I2F;
/**
* <p>Title: ConsoleStatusListener</p>
* <p>Description:实现与原有CAC控制台联动 </p>
* <p>Company: ZIT</p>
* @author lijiangtao
* @date   2018年7月3日
*/
public class ConsoleStatusListener implements ServletContextListener{

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		
		String tomcatLibPath=ControllScriptHolder.getSingleton().getTomcatLibPath();
		
		if(tomcatLibPath.contains("tomcat")) {
			try {
				new File(tomcatLibPath+AdminConst.SERVER_STARTED_TAG_FILENAME).
				createNewFile();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		
		String tomcatLibPath=ControllScriptHolder.getSingleton().getTomcatLibPath();
		
		if(tomcatLibPath.contains("tomcat")) {
			try {
				new File(tomcatLibPath+AdminConst.SERVER_STOPPED_TAG_FILENAME).
				createNewFile();
			} catch (IOException e) {
				e.printStackTrace();
			};
		}
	}
	
}
