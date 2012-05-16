package com.ocr;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.Socket;
import java.net.URL;
import java.net.URLConnection;

/**
 * @author yangliuis@pku.edu.cn
 * 
 */

public class ServerRun extends Thread implements Runnable {
	private static Integer invoicePicNum = 0;// 发票图片序号
	// private static Integer captchasPicNum = 0;//验证码图片序号
	private Socket socket;
	private final String invoiceDir = "F://Helios//data//invoice_image//";

	// private final String captchasDir = "F://Helios//data//captchas_image//";

	public ServerRun(Socket socket) {
		this.socket = socket;
	}

	public void run() {
		String invoicePicFilename = invoiceDir + "invoice_image_";
		invoicePicFilename += invoicePicNum + ".jpg";
		try {
			DataInputStream dis = new DataInputStream(socket.getInputStream());
			BufferedOutputStream bos = new BufferedOutputStream(
					new FileOutputStream(invoicePicFilename));
			byte buffer[] = new byte[1024];
			int eof = 0;
			while ((eof = dis.read(buffer, 0, 1024)) != -1) {
				bos.write(buffer, 0, eof);
			}
			System.out.println("收到图片" + invoicePicFilename + "开始识别该图片");
			String invoiceInfo[] = new String[10];
			// 发票信息包括发票代码、发票号码、发票密码
			String invoiceResult;// 识别结果
			invoiceInfo = doOCRInvoice(invoicePicFilename);
			invoiceResult = postCheckInvoice(invoiceInfo);
			System.out.println("发票验证结束，验证结果为：" + invoiceResult);
			bos.close();
			dis.close();
			socket.close();
			synchronized (invoicePicNum) {
				// invoicePicNum是图片序号，需要加锁，是多个线程操作互斥
				invoicePicNum++;
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @param invoiceInfo
	 */
	private String postCheckInvoice(String[] invoiceInfo) throws IOException {
		// TODO Auto-generated method stub
		String fpdm = invoiceInfo[0];
		String fphm = invoiceInfo[1];
		// String fphm = "27404666";//实验假发票的情况
		String fpmm = invoiceInfo[2];
		String result = "发票为假！";
		URL url;
		url = new URL("http://www.bjtax.gov.cn/ptfp/turn.jsp");
		URLConnection connection = url.openConnection();
		connection.setDoOutput(true);
		OutputStreamWriter out = new OutputStreamWriter(connection
				.getOutputStream(), "8859_1");
		String post = "fpdm="
				+ fpdm
				+ "&fphm="
				+ fphm
				+ "&fpmm="
				+ fpmm
				+ "&yzms=111111&sfzh=11111111111111111111&ip=127.0.0.1&isFrist=1";
		out.write(post);
		out.flush();
		out.close();
		String sCurrentLine = "";
		String sTotalString = "";
		InputStream l_urlStream = connection.getInputStream();
		BufferedReader l_reader = new BufferedReader(new InputStreamReader(
				l_urlStream, "utf-8"));
		while ((sCurrentLine = l_reader.readLine()) != null) {
			sTotalString = sCurrentLine + "\r\n";
			if (sTotalString.indexOf("正确查询") != -1)
				result = "发票为真！";
		}
		return result;
	}

	/**
	 * @param String
	 *            invoicePicFilename
	 * @return String[] invoiceInfo
	 * @throws InterruptedException
	 * @throws IOException
	 */
	private String[] doOCRInvoice(String invoicePicFilename)
			throws InterruptedException, IOException {
		// TODO Auto-generated method stub
		String invoiceInfo[] = new String[10];
		// 图像裁剪
		OperateImage oPassword = new OperateImage(700, 2450, 400, 170);
		try {
			oPassword.setSrcpath(invoicePicFilename);
			oPassword.setSubpath(invoiceDir + "password" + invoicePicNum
					+ ".jpg");
			oPassword.cut();
			OperateImage oNumber = new OperateImage(320, 80, 800, 300);
			oNumber.setSrcpath(invoicePicFilename);
			oNumber.setSubpath(invoiceDir + "number" + invoicePicNum + ".jpg");
			oNumber.cut();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 过滤背景色及图像二值化
		new SoundBinImage().releaseSound(invoiceDir + "password"
				+ invoicePicNum + ".jpg", invoiceDir + "binpassword"
				+ invoicePicNum + ".png", 60);
		new SoundBinImage().releaseSound(invoiceDir + "number" + invoicePicNum
				+ ".jpg", invoiceDir + "binnumber" + invoicePicNum + ".png",
				130);// png识别准确度更高

		// OCR识别
		String invoiceBinNumberFileName = invoiceDir + "binnumbertxt"
				+ invoicePicNum;
		String invoiceBinPasswordFileName = invoiceDir + "binpasswordtxt"
				+ invoicePicNum;
		Runtime run = Runtime.getRuntime();
		Process pr1 = run.exec("cmd.exe /c tesseract " + invoiceDir
				+ "binnumber" + invoicePicNum + ".png" + " "
				+ invoiceBinNumberFileName + " -l eng");
		Process pr2 = run.exec("cmd.exe /c tesseract " + invoiceDir
				+ "binpassword" + invoicePicNum + ".png" + " "
				+ invoiceBinPasswordFileName + " -l eng");
		pr1.waitFor();// 让调用线程阻塞，直到exec调用OCR完毕，否则会报错找不到txt文件
		pr2.waitFor();
		String line;
		int i = 0;
		// 注意这里生成txt是需要时间的，所有进程需要等待直到返回再继续执行，否则就会找不到文件
		FileReader frNum = new FileReader(invoiceBinNumberFileName + ".txt");
		FileReader frPass = new FileReader(invoiceBinPasswordFileName + ".txt");
		BufferedReader brNum = new BufferedReader(frNum);
		while ((line = brNum.readLine()) != null) {
			invoiceInfo[i++] = line;
		}
		BufferedReader brPass = new BufferedReader(frPass);
		i--;
		while ((line = brPass.readLine()) != null) {
			invoiceInfo[i++] = line;
		}
		brNum.close();
		brPass.close();
		frNum.close();
		frPass.close();
		System.out.println("OCR识别结果：" + invoiceInfo[0] + " " + invoiceInfo[1]
				+ " " + invoiceInfo[2]);
		return invoiceInfo;
	}

}