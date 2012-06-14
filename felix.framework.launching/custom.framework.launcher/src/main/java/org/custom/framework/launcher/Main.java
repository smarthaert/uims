package org.custom.framework.launcher;

import java.io.BufferedReader;
import java.io.InputStreamReader;

import org.apache.felix.main.AutoProcessor;
import org.osgi.framework.launch.Framework;
import org.osgi.framework.launch.FrameworkFactory;

public class Main {
	private static Framework m_fwk = null;

	public static void main(String[] argv) throws Exception {
		// Print welcome banner.
		System.out.println("\nWelcome to My Launcher");
		System.out.println("======================\n");

		try {
			//获得框架实例
			m_fwk = getFrameworkFactory().newFramework(null);
			m_fwk.init();
			//用来自动部署shell bundles【 auto-deploy目录默认为bundle目录】
			//没有使用配置文件，默认安装shell bundle
			AutoProcessor.process(null, m_fwk.getBundleContext());
			//启动框架并等待退出
			m_fwk.start();
			m_fwk.waitForStop(0);
			System.exit(0);
		} catch (Exception ex) {
			System.err.println("Could not create framework: " + ex);
			ex.printStackTrace();
			System.exit(-1);
		}
	}

	private static FrameworkFactory getFrameworkFactory() throws Exception {
		//以当前类的目录为基础查找资源文件。
		java.net.URL url = Main.class.getClassLoader().getResource(
				"META-INF/services/org.osgi.framework.launch.FrameworkFactory");
		if (url != null) {
			BufferedReader br = new BufferedReader(new InputStreamReader(
					url.openStream()));
			try {
				for (String s = br.readLine(); s != null; s = br.readLine()) {
					s = s.trim();
					// Try to load first non-empty, non-commented line.
					if ((s.length() > 0) && (s.charAt(0) != '#')) {
						return (FrameworkFactory) Class.forName(s)
								.newInstance();
					}
				}
			} finally {
				if (br != null)
					br.close();
			}
		}

		throw new Exception("Could not find framework factory.");
	}
}