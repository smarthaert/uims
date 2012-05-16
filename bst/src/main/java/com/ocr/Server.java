package com.ocr;  
import java.net.ServerSocket;  
import java.util.concurrent.ExecutorService;  
import java.util.concurrent.Executors;  
import java.io.IOException;  
  
/** 
 * @author yangliuis@pku.edu.cn 
 * 
 */  
  
public class Server extends Thread{  
    private int port ;  
    private ServerSocket server;  
    private ExecutorService threadPool;//线程池   
      
    public Server(int port) {  
        super();  
        this.port = port;  
    }  
      
    public void startServer ()throws IOException{  
        server = new ServerSocket(port);  
        threadPool = Executors.newCachedThreadPool();  
        System.out.println("欢迎使用Helios系统，服务器启动");  
        this.start();  
    }  
      
    public void run(){  
        while(true){   
            try {  
                ServerRun task = new ServerRun(server.accept());  
                threadPool.execute(task);  
            } catch (IOException e) {  
                // TODO Auto-generated catch block   
                e.printStackTrace();  
            }  
        }  
    }  
    /** 
     * @param args 
     * @throws IOException  
     */  
    public static void main(String[] args) throws IOException {  
        // TODO Auto-generated method stub   
        Server server = new Server(8089);  
        server.startServer();  
    }  
}