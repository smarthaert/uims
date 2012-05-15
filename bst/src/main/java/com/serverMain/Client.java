01.package com.serverMain;  
02.import java.io.BufferedInputStream;  
03.import java.io.DataOutputStream;  
04.import java.io.FileInputStream;  
05.import java.io.FileNotFoundException;  
06.import java.io.IOException;  
07.import java.net.Socket;  
08.  
09./** 
10. * @author yangliuis@pku.edu.cn 
11. * 
12. */  
13.  
14.public class Client {  
15.    private Socket socket;  
16.    public Client(){  
17.          
18.    }  
19.    public void SendImage() throws IOException{  
20.        String imageFileName = "F://Helios//android//invoice_test.jpg";  
21.        socket = new Socket("192.168.1.102", 8089);  
22.        try {  
23.            BufferedInputStream bis =new BufferedInputStream(new FileInputStream(imageFileName));  
24.            DataOutputStream dos = new DataOutputStream(socket.getOutputStream());  
25.            byte buffer[] = new byte[1024];//一次读1K，循环读写图片字节流   
26.            int eof = 0;  
27.            while((eof = bis.read(buffer, 0 ,1024)) != -1){  
28.                dos.write(buffer, 0, eof);  
29.            }  
30.            dos.close();  
31.            bis.close();  
32.            socket.close();  
33.        } catch (FileNotFoundException e) {  
34.            // TODO Auto-generated catch block   
35.            e.printStackTrace();  
36.        }  
37.    }  
38.  
39.    public static void main(String s[]) throws IOException {  
40.        Client client = new Client();  
41.        client.SendImage();  
42.    }  
43.}