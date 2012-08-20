package com.bst.pro;

/** 
 * 二进制读写文件 
 */
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class TDXTest extends CIOUtil{
	
	public static void main(String[] args) {
		tdxWriteTest();
		tdxReadTest();
		
//		writeMethod1();
//		readMethod1();
//		
//		writeMethod2();
//		readMethod2();
	}
	
	public static void tdxReadTest() {
		String fileName = "D:\\Program Files\\GTJARZ\\Vipdoc\\sh\\lday\\sh900001.day";
		int sum = 0;
		try {
			DataInputStream in = new DataInputStream(new BufferedInputStream(
					new FileInputStream(fileName)));

			readLine(in);
			readLine(in);
			
			in.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void tdxWriteTest() {
		String fileName = "D:\\Program Files\\GTJARZ\\Vipdoc\\sh\\lday\\sh900001.day";
		int sum = 0;
		try {
			DataOutputStream out = new DataOutputStream(
					new BufferedOutputStream(new FileOutputStream(fileName)));

			writeLine(out);
			
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static void writeLine(DataOutputStream out) throws IOException {
//		out.writeInt(20080107);
//		out.writeInt(535745);
//		out.writeInt(540335);
//		out.writeInt(533260);
//		out.writeInt(539334);
//		out.writeInt(1377339563);
//		out.writeInt(97223910);
//		out.writeInt(12190391);
		writeInt(out, 20080107);
		writeInt(out, 535745);
		writeInt(out, 540335);
		writeInt(out, 533260);
		writeInt(out, 539334);
		writeInt(out, 1377339563);
		writeInt(out, 97223910);
		writeInt(out, 12190391);
//		
//
//		out.writeInt(20080107);
//		out.writeInt(541456);
//		out.writeInt(548007);
//		out.writeInt(534465);
//		out.writeInt(538653);
//		out.writeInt(1378765353);
//		out.writeInt(111114400);
//		out.writeInt(46989488);
		writeInt(out, 20080107);
		writeInt(out, 541456);
		writeInt(out, 548007);
		writeInt(out, 534465);
		writeInt(out, 538653);
		writeInt(out, 1378765353);
		writeInt(out, 111114400);
		writeInt(out, 46989488);
	}
	

	private static void readLine(DataInputStream in) throws IOException {
		
		System.out.println(readInt(in));
		System.out.println((float)readInt(in)/100);
		System.out.println((float)readInt(in)/100);
		System.out.println((float)readInt(in)/100);
		System.out.println((float)readInt(in)/100);
		System.out.println(readInt(in));
		System.out.println((float)readInt(in)/100);
		System.out.println(readInt(in));
	}
	
	/**
	 * java.io包中的OutputStream及其子类专门用于写二进制数据。 FileOutputStream是其子类，可用于将二进制数据写入文件。
	 * DataOutputStream是OutputStream的另一个子类，它可以
	 * 连接到一个FileOutputStream上，便于写各种基本数据类型的数据。
	 */
	public static void writeMethod1() {
		String fileName = "c:/kuka1.dat";
		int value0 = 20080107;
		int value1 = 0;
		int value2 = -1;
		try {
			// 将DataOutputStream与FileOutputStream连接可输出不同类型的数据
			// FileOutputStream类的构造函数负责打开文件kuka.dat，如果文件不存在，
			// 则创建一个新的文件，如果文件已存在则用新创建的文件代替。然后FileOutputStream
			// 类的对象与一个DataOutputStream对象连接，DataOutputStream类具有写
			// 各种数据类型的方法。
			DataOutputStream out = new DataOutputStream(new FileOutputStream(
					fileName));
			out.writeInt(value0);
			out.writeInt(value1);
			out.writeInt(value2);
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 对于大量数据的写入，使用缓冲流BufferedOutputStream类可以提高效率
	public static void writeMethod2() {
		String fileName = "c:/kuka2.dat";
		try {
			DataOutputStream out = new DataOutputStream(
					new BufferedOutputStream(new FileOutputStream(fileName)));
			out.writeInt(10);
			System.out.println(out.size() + " bytes have been written.");
			out.writeDouble(31.2);
			System.out.println(out.size() + " bytes have been written.");
			out.writeBytes("JAVA");
			System.out.println(out.size() + " bytes have been written.");
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 对二进制文件比较常见的类有FileInputStream，DataInputStream
	 * BufferedInputStream等。类似于DataOutputStream，DataInputStream
	 * 也提供了很多方法用于读入布尔型、字节、字符、整形、长整形、短整形、 单精度、双精度等数据。
	 */
	public static void readMethod1() {
		String fileName = "c:/kuka1.dat";
		int sum = 0;
		try {
			DataInputStream in = new DataInputStream(new BufferedInputStream(
					new FileInputStream(fileName)));
			sum += in.readInt();
			sum += in.readInt();
			sum += in.readInt();
			System.out.println("The sum is:" + sum);
			in.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void readMethod2() {
		try {
			FileInputStream stream = new FileInputStream("c:/kuka2.dat");
			int c;
			while ((c = stream.read()) != -1) {
				System.out.println(c);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}