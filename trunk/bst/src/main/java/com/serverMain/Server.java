01.package com.serverMain;  
02.import java.net.ServerSocket;  
03.import java.util.concurrent.ExecutorService;  
04.import java.util.concurrent.Executors;  
05.import java.io.IOException;  
06.  
07./** 
08. * @author yangliuis@pku.edu.cn 
09. * 
10. */  
11.  
12.public class Server extends Thread{  
13.    private int port ;  
14.    private ServerSocket server;  
15.    private ExecutorService threadPool;//线程池   
16.      
17.    public Server(int port) {  
18.        super();  
19.        this.port = port;  
20.    }  
21.      
22.    public void startServer ()throws IOException{  
23.        server = new ServerSocket(port);  
24.        threadPool = Executors.newCachedThreadPool();  
25.        System.out.println("欢迎使用Helios系统，服务器启动");  
26.        this.start();  
27.    }  
28.      
29.    public void run(){  
30.        while(true){   
31.            try {  
32.                ServerRun task = new ServerRun(server.accept());  
33.                threadPool.execute(task);  
34.            } catch (IOException e) {  
35.                // TODO Auto-generated catch block   
36.                e.printStackTrace();  
37.            }  
38.        }  
39.    }  
40.    /** 
41.     * @param args 
42.     * @throws IOException  
43.     */  
44.    public static void main(String[] args) throws IOException {  
45.        // TODO Auto-generated method stub   
46.        Server server = new Server(8089);  
47.        server.startServer();  
48.    }  
49.}