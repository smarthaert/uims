
13.        try {  
14.            BufferedImage bi=ImageIO.read(new File(filepath));  
15.            int width=bi.getWidth();  
16.            int height=bi.getHeight();  
17.            BufferedImage bi2=new BufferedImage(width,height,BufferedImage.TYPE_INT_ARGB);  
18.            Raster raster=bi.getRaster();  
19.            WritableRaster wr=bi2.getRaster();  
20.            for(int i=0;i<width;i++){  
21.                for(int j=0;j<height;j++){  
22.                    int[] a=new int[4];  
23.                    raster.getPixel(i, j, a);  
24.                    //System.out.println("("+a[0]+", "+a[1]+", "+a[2]+", "+a[3]+")");   
25.                    if((a[0]+a[1]+a[2])/3>Threshold){  
26.                        a[0]=255;  
27.                        a[1]=255;  
28.                        a[2]=255;  
29.                        a[3]=255;  
30.                        wr.setPixel(i, j, a);  
31.                    }else{  
32.                        a[0]=0;  
33.                        a[1]=0;  
34.                        a[2]=0;  
35.                        a[3]=255;  
36.                        wr.setPixel(i, j, a);  
37.   
38.                    }  
39.                }  
40.            }  
41.            ImageIO.write(bi2, "PNG", new File(destpath));  
42.        } catch (IOException e) {  
43.            e.printStackTrace();  
44.        }  
45.    }  
46.    public static void main(String[] args) {  
47.        new SoundBinImage().releaseSound("C:\\deletesound\\password1.jpg","C:\\deletesound\\result.png", 60);  
48.    }  
49.}