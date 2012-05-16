package com.ocr;  
import java.io.BufferedInputStream;  
import java.io.DataOutputStream;  
import java.io.FileInputStream;  
import java.io.FileNotFoundException;  
import java.io.IOException;  
import java.net.Socket;  
  
/** 
 * @author yangliuis@pku.edu.cn 
 * 
 */  
  
public class Client {  
    private Socket socket;  
    public Client(){  
          
    }  
    public void SendImage() throws IOException{  
        String imageFileName = "F://Helios//android//invoice_test.jpg";  
        socket = new Socket("192.168.1.102", 8089);  
        try {  
            BufferedInputStream bis =new BufferedInputStream(new FileInputStream(imageFileName));  
            DataOutputStream dos = new DataOutputStream(socket.getOutputStream());  
            byte buffer[] = new byte[1024];//一次读1K，循环读写图片字节流   
            int eof = 0;  
            while((eof = bis.read(buffer, 0 ,1024)) != -1){  
                dos.write(buffer, 0, eof);  
            }  
            dos.close();  
            bis.close();  
            socket.close();  
        } catch (FileNotFoundException e) {  
            // TODO Auto-generated catch block   
            e.printStackTrace();  
        }  
    }  
  
    public static void main(String s[]) throws IOException {  
        Client client = new Client();  
        client.SendImage();  
    }  
}