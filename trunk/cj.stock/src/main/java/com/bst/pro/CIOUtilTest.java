package com.bst.pro;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;

import org.junit.Test;
import static org.junit.Assert.*;

/**
 * 
 * @author Snowolf
 * @version 1.0
 * @since 1.0
 */
public class CIOUtilTest {
	/**
	 * 测试布尔值
	 * 
	 * @throws IOException
	 */
	@Test
	public final void testBoolean() throws IOException {
		boolean input = true;
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		DataOutputStream os = new DataOutputStream(baos);

		CIOUtil.writeBoolean(os, input);

		byte[] b = baos.toByteArray();
		baos.flush();
		baos.close();

		ByteArrayInputStream bais = new ByteArrayInputStream(b);
		DataInputStream is = new DataInputStream(bais);

		boolean output = CIOUtil.readBoolean(is);

		bais.close();

		assertEquals(input, output);
	}

	/**
	 * 测试字节数组
	 * 
	 * @throws IOException
	 */
	@Test
	public final void testBytes() throws IOException {
		byte[] input = "中文".getBytes("UTF-8");
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		DataOutputStream os = new DataOutputStream(baos);

		CIOUtil.writeBytes(os, input);

		byte[] b = baos.toByteArray();
		baos.flush();
		baos.close();

		ByteArrayInputStream bais = new ByteArrayInputStream(b);
		DataInputStream is = new DataInputStream(bais);

		byte[] output = CIOUtil.readBytes(is, 6);

		bais.close();

		assertArrayEquals(input, output);
	}

	/**
	 * 测试字符
	 * 
	 * @throws IOException
	 */
	@Test
	public final void testChar() throws IOException {
		char input = '中';
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		DataOutputStream os = new DataOutputStream(baos);

		CIOUtil.writeChar(os, input);

		byte[] b = baos.toByteArray();
		baos.flush();
		baos.close();

		ByteArrayInputStream bais = new ByteArrayInputStream(b);
		DataInputStream is = new DataInputStream(bais);

		char output = CIOUtil.readChar(is);

		bais.close();

		assertEquals(input, output);
	}

	/**
	 * 测试双精度
	 * 
	 * @throws IOException
	 */
	@Test
	public final void testDouble() throws IOException {
		double input = 1.23456789d;
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		DataOutputStream os = new DataOutputStream(baos);

		CIOUtil.writeDouble(os, input);

		byte[] b = baos.toByteArray();
		baos.flush();
		baos.close();

		ByteArrayInputStream bais = new ByteArrayInputStream(b);
		DataInputStream is = new DataInputStream(bais);

		double output = CIOUtil.readDouble(is);

		bais.close();

		assertEquals(input, output, 9);
	}

	/**
	 * 测试单精度
	 * 
	 * @throws IOException
	 */
	@Test
	public final void testFloat() throws IOException {
		float input = 1.23456789f;
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		DataOutputStream os = new DataOutputStream(baos);

		CIOUtil.writeFloat(os, input);

		byte[] b = baos.toByteArray();
		baos.flush();
		baos.close();

		ByteArrayInputStream bais = new ByteArrayInputStream(b);
		DataInputStream is = new DataInputStream(bais);

		float output = CIOUtil.readFloat(is);

		bais.close();

		assertEquals(input, output, 9);
	}

	/**
	 * 测试整型
	 * 
	 * @throws IOException
	 */
	@Test
	public final void testInt() throws IOException {
		int input = 1;
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		DataOutputStream os = new DataOutputStream(baos);

		CIOUtil.writeInt(os, input);

		byte[] b = baos.toByteArray();
		baos.flush();
		baos.close();

		ByteArrayInputStream bais = new ByteArrayInputStream(b);
		DataInputStream is = new DataInputStream(bais);

		int output = CIOUtil.readInt(is);

		bais.close();

		assertEquals(input, output);
	}

	/**
	 * 测试长整型
	 * 
	 * @throws IOException
	 */
	@Test
	public final void testLong() throws IOException {
		long input = 1l;
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		DataOutputStream os = new DataOutputStream(baos);

		CIOUtil.writeLong(os, input);

		byte[] b = baos.toByteArray();
		baos.flush();
		baos.close();

		ByteArrayInputStream bais = new ByteArrayInputStream(b);
		DataInputStream is = new DataInputStream(bais);

		long output = CIOUtil.readLong(is);

		bais.close();

		assertEquals(input, output);
	}

	/**
	 * 测试短整型
	 * 
	 * @throws IOException
	 */
	@Test
	public final void testShort() throws IOException {
		short input = 1;
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		DataOutputStream os = new DataOutputStream(baos);

		CIOUtil.writeShort(os, input);

		byte[] b = baos.toByteArray();
		baos.flush();
		baos.close();

		ByteArrayInputStream bais = new ByteArrayInputStream(b);
		DataInputStream is = new DataInputStream(bais);

		short output = CIOUtil.readShort(is);

		bais.close();

		assertEquals(input, output);
	}

	/**
	 * 测试UTF-8字符串
	 * 
	 * @throws IOException
	 */
	@Test
	public final void testUTF() throws IOException {
		String input = "中文支持";
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		DataOutputStream os = new DataOutputStream(baos);

		CIOUtil.writeUTF(os, input);

		byte[] b = baos.toByteArray();
		baos.flush();
		baos.close();

		ByteArrayInputStream bais = new ByteArrayInputStream(b);
		DataInputStream is = new DataInputStream(bais);

		String output = CIOUtil.readUTF(is);

		bais.close();

		assertEquals(input, output);
	}

}