01.package com.serverMain;  
02.import java.net.Socket;  
03.import java.net.URL;  
04.import java.net.URLConnection;  
05.import java.io.BufferedReader;  
06.import java.io.DataInputStream;  
07.import java.io.BufferedOutputStream;  
08.import java.io.FileOutputStream;  
09.import java.io.FileReader;  
10.import java.io.IOException;  
11.import java.io.InputStream;  
12.import java.io.InputStreamReader;  
13.import java.io.OutputStreamWriter;  
14.  
15.import com.imageHandle.OperateImage;  
16.import com.imageHandle.SoundBinImage;  
17.  
18./** 
19. * @author yangliuis@pku.edu.cn 
20. * 
21. */  
22.  
23.public class ServerRun extends Thread implements Runnable{  
24.    private static Integer invoicePicNum = 0;//发票图片序号   
25.    //private static Integer captchasPicNum = 0;//验证码图片序号   
26.    private Socket socket;  
27.    private final String  invoiceDir = "F://Helios//data//invoice_image//";  
28.    //private final String  captchasDir = "F://Helios//data//captchas_image//";   
29.          
30.    public ServerRun(Socket socket){  
31.        this.socket = socket;  
32.    }  
33.      
34.    public void run(){  
35.        String invoicePicFilename = invoiceDir+"invoice_image_";  
36.        invoicePicFilename += invoicePicNum+".jpg";       
37.        try {  
38.            DataInputStream dis = new DataInputStream(socket.getInputStream());  
39.            BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(invoicePicFilename));  
40.            byte buffer[] = new byte[1024];  
41.            int eof = 0;  
42.            while((eof = dis.read(buffer, 0, 1024)) != -1) {  
43.                bos.write(buffer, 0 ,eof);  
44.            }  
45.            System.out.println("收到图片"+invoicePicFilename+"开始识别该图片");  
46.            String invoiceInfo[] = new String[10];  
47.            //发票信息包括发票代码、发票号码、发票密码   
48.            String invoiceResult;//识别结果   
49.            invoiceInfo = doOCRInvoice(invoicePicFilename);  
50.            invoiceResult = postCheckInvoice(invoiceInfo);  
51.            System.out.println("发票验证结束，验证结果为："+invoiceResult);  
52.            bos.close();  
53.            dis.close();  
54.            socket.close();  
55.            synchronized (invoicePicNum){  
56.            //invoicePicNum是图片序号，需要加锁，是多个线程操作互斥   
57.                invoicePicNum++;  
58.            }  
59.        } catch (IOException e) {  
60.            // TODO Auto-generated catch block   
61.            e.printStackTrace();  
62.        } catch (InterruptedException e) {  
63.            // TODO Auto-generated catch block   
64.            e.printStackTrace();  
65.        }     
66.    }  
67.  
68.    /** 
69.     * @param invoiceInfo 
70.     */  
71.    private String postCheckInvoice(String[] invoiceInfo) throws IOException{  
72.        // TODO Auto-generated method stub   
73.        String fpdm = invoiceInfo[0];  
74.        String fphm = invoiceInfo[1];  
75.        //String fphm = "27404666";//实验假发票的情况   
76.        String fpmm = invoiceInfo[2];  
77.        String result = "发票为假！";  
78.        URL url;      
79.        url = new URL("http://www.bjtax.gov.cn/ptfp/turn.jsp");  
80.        URLConnection connection = url.openConnection();  
81.        connection.setDoOutput(true);  
82.        OutputStreamWriter out = new OutputStreamWriter(connection.getOutputStream(),"8859_1");  
83.        String post = "fpdm="+fpdm+"&fphm="+fphm+"&fpmm="+fpmm+"&yzms=111111&sfzh=11111111111111111111&ip=127.0.0.1&isFrist=1";  
84.        out.write(post);      
85.        out.flush();  
86.        out.close();  
87.        String sCurrentLine = "";  
88.        String sTotalString = "";  
89.        InputStream l_urlStream = connection.getInputStream();  
90.        BufferedReader l_reader = new BufferedReader(new InputStreamReader(l_urlStream, "utf-8"));  
91.        while((sCurrentLine = l_reader.readLine()) != null)  
92.        {  
93.            sTotalString = sCurrentLine +"\r\n";  
94.            if(sTotalString.indexOf("正确查询")!=-1)  
95.                result = "发票为真！";         
96.        }     
97.        return result;    
98.    }  
99.  
100.    /** 
101.     * @param String invoicePicFilename 
102.     * @return String[] invoiceInfo 
103.     * @throws InterruptedException  
104.     * @throws IOException  
105.     */  
106.    private String[] doOCRInvoice(String invoicePicFilename) throws InterruptedException, IOException {  
107.        // TODO Auto-generated method stub   
108.        String invoiceInfo[] = new String[10];  
109.        //图像裁剪   
110.        OperateImage oPassword  =   new  OperateImage(700,2450,400,170);  
111.        try {  
112.        oPassword.setSrcpath(invoicePicFilename);    
113.        oPassword.setSubpath( invoiceDir+"password"+invoicePicNum+".jpg");  
114.        oPassword.cut() ;   
115.        OperateImage oNumber  =   new  OperateImage(320,80,800,300);  
116.        oNumber.setSrcpath(invoicePicFilename);    
117.        oNumber.setSubpath(invoiceDir+"number"+invoicePicNum+".jpg");  
118.        oNumber.cut() ;      
119.        } catch (IOException e) {  
120.            // TODO Auto-generated catch block   
121.            e.printStackTrace();  
122.        }   
123.        //过滤背景色及图像二值化   
124.        new SoundBinImage().releaseSound(invoiceDir+"password"+invoicePicNum+".jpg",invoiceDir+"binpassword"+invoicePicNum+".png",60);  
125.        new SoundBinImage().releaseSound(invoiceDir+"number"+invoicePicNum+".jpg",invoiceDir+"binnumber"+invoicePicNum+".png",130);//png识别准确度更高   
126.          
127.        //OCR识别   
128.        String invoiceBinNumberFileName = invoiceDir+"binnumbertxt"+invoicePicNum;  
129.        String invoiceBinPasswordFileName = invoiceDir+"binpasswordtxt"+invoicePicNum;  
130.        Runtime run = Runtime.getRuntime();         
131.        Process pr1 = run.exec("cmd.exe /c tesseract "+invoiceDir+"binnumber"+invoicePicNum+".png"+" "+invoiceBinNumberFileName+" -l eng");  
132.        Process pr2 = run.exec("cmd.exe /c tesseract "+invoiceDir+"binpassword"+invoicePicNum+".png"+" "+invoiceBinPasswordFileName+" -l eng");  
133.        pr1.waitFor();//让调用线程阻塞，直到exec调用OCR完毕，否则会报错找不到txt文件   
134.        pr2.waitFor();  
135.        String line;  
136.        int i = 0;  
137.        //注意这里生成txt是需要时间的，所有进程需要等待直到返回再继续执行，否则就会找不到文件   
138.        FileReader frNum = new FileReader(invoiceBinNumberFileName+".txt");  
139.        FileReader frPass = new FileReader(invoiceBinPasswordFileName+".txt");  
140.        BufferedReader brNum = new BufferedReader(frNum);  
141.        while ((line = brNum.readLine()) != null)  
142.        {  
143.            invoiceInfo[i++] = line;  
144.        }  
145.        BufferedReader brPass = new BufferedReader(frPass);  
146.        i--;  
147.        while ((line = brPass.readLine()) != null)  
148.        {  
149.            invoiceInfo[i++] = line;  
150.        }  
151.        brNum.close();  
152.        brPass.close();   
153.        frNum.close();  
154.        frPass.close();  
155.        System.out.println("OCR识别结果："+invoiceInfo[0]+" "+invoiceInfo[1]+" "+invoiceInfo[2]);  
156.        return invoiceInfo;  
157.    }  
158.  
159.} 