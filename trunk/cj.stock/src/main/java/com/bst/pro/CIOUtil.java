package com.bst.pro;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;

/**
 * 仅仅适用于 Java 与 C++ 通讯中，网络流解析与生成使用
 * 
 * 高低位互换(Big-Endian 大头在前 &amp; Little-Endian 小头在前)。
 * 举例而言，有一个4字节的数据0x01020304，要存储在内存中或文件中编号0&tilde;3字节的位置，两种字节序的排列方式分别如下：
 * 
 * <pre>
 * Big Endian 
 *   
 * 低地址                           高地址 
 * ----------------------------------------------------&gt; 
 * 地址编号 
 * |     0      |      1     |     2       |      3    | 
 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ 
 * |     01     |      02    |     03      |     04    | 
 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ 
 *  
 * Little Endian 
 *  
 * 低地址                           高地址 
 * ----------------------------------------------------&gt; 
 * 地址编号 
 * |     0      |      1     |     2       |      3    | 
 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ 
 * |     04     |      03    |     02      |     01    | 
 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 * </pre>
 * 
 * Java则统一使用big模式 c中的unsigned short 对应着java中的char两个字节，无符号
 * c的无符号int,short,byte字节数组，相应转换成java的long,char,short
 * 
 * @author Snowolf
 * @version 1.0
 * @since 1.0
 */
public abstract class CIOUtil {
	public static final String CHARSET = "UTF-8";

	/**
	 * 从输入流中读布尔
	 * 
	 * @param is
	 * @return
	 * @throws IOException
	 */
	public static boolean readBoolean(DataInputStream is) throws IOException {
		return is.readBoolean();
	}

	/**
	 * 从流中读定长度字节数组
	 * 
	 * @param is
	 * @param s
	 * @return
	 * @throws IOException
	 */
	public static byte[] readBytes(DataInputStream is, int i)
			throws IOException {
		byte[] data = new byte[i];
		is.readFully(data);

		return data;
	}

	/**
	 * 从输入流中读字符
	 * 
	 * @param is
	 * @return
	 * @throws IOException
	 */
	public static char readChar(DataInputStream is) throws IOException {
		return (char) readShort(is);
	}

	/**
	 * 从输入流中读双精度
	 * 
	 * @param is
	 * @return
	 * @throws IOException
	 */
	public static double readDouble(DataInputStream is) throws IOException {
		return Double.longBitsToDouble(readLong(is));
	}

	/**
	 * 从输入流中读单精度
	 * 
	 * @param is
	 * @return
	 * @throws IOException
	 */
	public static float readFloat(DataInputStream is) throws IOException {
		return Float.intBitsToFloat(readInt(is));
	}

	/**
	 * 从流中读整型
	 * 
	 * @param is
	 * @return
	 * @throws IOException
	 */
	public static int readInt(DataInputStream is) throws IOException {
		return Integer.reverseBytes(is.readInt());
	}

	/**
	 * 从流中读长整型
	 * 
	 * @param is
	 * @return
	 * @throws IOException
	 */
	public static long readLong(DataInputStream is) throws IOException {
		return Long.reverseBytes(is.readLong());
	}

	/**
	 * 从流中读短整型
	 * 
	 * @param is
	 * @return
	 * @throws IOException
	 */
	public static short readShort(DataInputStream is) throws IOException {
		return Short.reverseBytes(is.readShort());
	}

	/**
	 * 从输入流中读字符串 字符串 结构 为 一个指定字符串字节长度的短整型+实际字符串
	 * 
	 * @param is
	 * @return
	 * @throws IOException
	 */
	public static String readUTF(DataInputStream is) throws IOException {
		short s = readShort(is);
		byte[] str = new byte[s];

		is.readFully(str);

		return new String(str, CHARSET);
	}

	/**
	 * 向输出流中写布尔
	 * 
	 * @param os
	 * @param b
	 * @throws IOException
	 */
	public static void writeBoolean(DataOutputStream os, boolean b)
			throws IOException {
		os.writeBoolean(b);
	}

	/**
	 * 向输出流中写字节数组
	 * 
	 * @param os
	 * @param data
	 * @throws IOException
	 */
	public static void writeBytes(DataOutputStream os, byte[] data)
			throws IOException {
		os.write(data);
	}

	/**
	 * 向输出流中写字符
	 * 
	 * @param os
	 * @param b
	 * @throws IOException
	 */
	public static void writeChar(DataOutputStream os, char b)
			throws IOException {
		writeShort(os, (short) b);
	}

	/**
	 * 向输出流中写双精度
	 * 
	 * @param os
	 * @param d
	 * @throws IOException
	 */
	public static void writeDouble(DataOutputStream os, double d)
			throws IOException {
		writeLong(os, Double.doubleToLongBits(d));
	}

	/**
	 * 向输出流中写单精度
	 * 
	 * @param os
	 * @param f
	 * @throws IOException
	 */
	public static void writeFloat(DataOutputStream os, float f)
			throws IOException {
		writeInt(os, Float.floatToIntBits(f));
	}

	/**
	 * 向输出流中写整型
	 * 
	 * @param os
	 * @param i
	 * @throws IOException
	 */
	public static void writeInt(DataOutputStream os, int i) throws IOException {
		os.writeInt(Integer.reverseBytes(i));
	}

	/**
	 * 向输出流中写长整型
	 * 
	 * @param os
	 * @param l
	 * @throws IOException
	 */
	public static void writeLong(DataOutputStream os, long l)
			throws IOException {
		os.writeLong(Long.reverseBytes(l));
	}

	/**
	 * 向输出流中写短整型
	 * 
	 * @param os
	 * @param s
	 * @throws IOException
	 */
	public static void writeShort(DataOutputStream os, short s)
			throws IOException {
		os.writeShort(Short.reverseBytes(s));
	}

	/**
	 * 向输出流中写字符串 字符串 结构 为 一个指定字符串字节长度的短整型+实际字符串
	 * 
	 * @param os
	 * @param str
	 * @throws IOException
	 */
	public static void writeUTF(DataOutputStream os, String str)
			throws IOException {
		byte[] data = str.getBytes(CHARSET);
		writeShort(os, (short) data.length);
		os.write(data);
	}

}