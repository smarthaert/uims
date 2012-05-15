01.package com.imageHandle;  
02.  
03.import java.awt.Rectangle;  
04.import java.awt.image.BufferedImage;  
05.import java.io.File;  
06.import java.io.FileInputStream;  
07.import java.io.IOException;  
08.import java.util.Iterator;  
09.  
10.import javax.imageio.ImageIO;  
11.import javax.imageio.ImageReadParam;  
12.import javax.imageio.ImageReader;  
13.import javax.imageio.stream.ImageInputStream;  
14.  
15.  
16.public class OperateImage {  
17.         
18.    //===源图片路径名称如:c:/1.jpg    
19.    private String srcpath ;  
20.           
21.    //===剪切图片存放路径名称.如:c:/2.jpg   
22.    private String subpath ;  
23.      
24.    //===剪切点x坐标   
25.    private int x ;  
26.      
27.    private int y ;      
28.        
29.    //===剪切点宽度   
30.    private int width ;  
31.       
32.    private int height ;  
33.      
34.    public OperateImage(){  
35.              
36.    }    
37.    public OperateImage(int x,int y,int width,int height){  
38.         this.x = x ;  
39.         this.y = y ;  
40.         this.width = width ;     
41.         this.height = height ;  
42.    }  
43.      
44.    /**  
45.     * 对图片裁剪，并把裁剪完蛋新图片保存 。 
46.     */  
47.    public void cut() throws IOException{   
48.           
49.        FileInputStream is = null ;  
50.        ImageInputStream iis =null ;  
51.       
52.        try{     
53.            //读取图片文件   
54.            is = new FileInputStream(srcpath);   
55.              
56.            /* 
57.             * 返回包含所有当前已注册 ImageReader 的 Iterator，这些 ImageReader  
58.             * 声称能够解码指定格式。 参数：formatName - 包含非正式格式名称 . 
59.             *（例如 "jpeg" 或 "tiff"）等 。  
60.             */  
61.            Iterator<ImageReader> it = ImageIO.getImageReadersByFormatName("jpg");    
62.            ImageReader reader = it.next();   
63.            //获取图片流    
64.            iis = ImageIO.createImageInputStream(is);  
65.                 
66.            /*  
67.             * <p>iis:读取源.true:只向前搜索 </p>.将它标记为 ‘只向前搜索’。 
68.             * 此设置意味着包含在输入源中的图像将只按顺序读取，可能允许 reader 
69.             *  避免缓存包含与以前已经读取的图像关联的数据的那些输入部分。 
70.             */  
71.            reader.setInput(iis,true);  
72.              
73.            /*  
74.             * <p>描述如何对流进行解码的类<p>.用于指定如何在输入时从 Java Image I/O  
75.             * 框架的上下文中的流转换一幅图像或一组图像。用于特定图像格式的插件 
76.             * 将从其 ImageReader 实现的 getDefaultReadParam 方法中返回  
77.             * ImageReadParam 的实例。   
78.             */  
79.            ImageReadParam param = reader.getDefaultReadParam();   
80.               
81.            /* 
82.             * 图片裁剪区域。Rectangle 指定了坐标空间中的一个区域，通过 Rectangle 对象 
83.             * 的左上顶点的坐标（x，y）、宽度和高度可以定义这个区域。  
84.             */   
85.            Rectangle rect = new Rectangle(x, y, width, height);   
86.              
87.                
88.            //提供一个 BufferedImage，将其用作解码像素数据的目标。    
89.            param.setSourceRegion(rect);   
90.  
91.            /* 
92.             * 使用所提供的 ImageReadParam 读取通过索引 imageIndex 指定的对象，并将 
93.             * 它作为一个完整的 BufferedImage 返回。 
94.             */  
95.            BufferedImage bi = reader.read(0,param);                  
96.        
97.            //保存新图片    
98.            ImageIO.write(bi, "jpg", new File(subpath));       
99.        }  
100.          
101.        finally{  
102.            if(is!=null)  
103.               is.close() ;         
104.            if(iis!=null)  
105.               iis.close();    
106.        }   
107.          
108.           
109.       
110.    }  
111.  
112.    public int getHeight() {  
113.        return height;  
114.    }  
115.  
116.    public void setHeight(int height) {  
117.        this.height = height;  
118.    }  
119.  
120.    public String getSrcpath() {  
121.        return srcpath;  
122.    }  
123.  
124.    public void setSrcpath(String srcpath) {  
125.        this.srcpath = srcpath;  
126.    }  
127.  
128.    public String getSubpath() {  
129.        return subpath;  
130.    }  
131.  
132.    public void setSubpath(String subpath) {  
133.        this.subpath = subpath;  
134.    }  
135.  
136.    public int getWidth() {  
137.        return width;  
138.    }  
139.  
140.    public void setWidth(int width) {  
141.        this.width = width;  
142.    }  
143.  
144.    public int getX() {  
145.        return x;  
146.    }  
147.  
148.    public void setX(int x) {  
149.        this.x = x;  
150.    }  
151.  
152.    public int getY() {  
153.        return y;  
154.    }  
155.  
156.    public void setY(int y) {  
157.        this.y = y;  
158.    }   
159.    public static void main(String[] args)throws Exception{  
160.         String name  =   "C:\\caijian\\bb.jpg" ;  
161.         OperateImage oPassword  =   new  OperateImage(700,2450,400,170);  
162.         oPassword.setSrcpath(name);    
163.         oPassword.setSubpath( "C:\\caijian\\bbpassword.jpg" );  
164.         oPassword.cut() ;    
165.         OperateImage oNumber  =   new  OperateImage(320,80,800,300);  
166.         oNumber.setSrcpath(name);    
167.         oNumber.setSubpath( "C:\\caijian\\bbnumber.jpg" );  
168.         oNumber.cut() ;       
169.    }  
170.  
171.  
172.}