package org.robot.ui.win32.screencapture;

import java.awt.BorderLayout;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Rectangle;
import java.awt.Robot;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.image.BufferedImage;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.WindowConstants;

class ScreenCapture {

	/**
	 * @param args
	 */
	private Robot robot = null;

	private Rectangle scrRect = null;

	public ScreenCapture() {
		try {
			robot = new Robot();
		} catch (Exception ex) {
			System.out.println(ex.toString());
		}
		Dimension scrSize = Toolkit.getDefaultToolkit().getScreenSize(); // ×ÀÃæÆÁÄ»³ß´ç
		scrRect = new Rectangle(0, 0, scrSize.width, scrSize.height);
	}

	public BufferedImage captureScreen() {
		BufferedImage bufImg = null;

		try {
			bufImg = robot.createScreenCapture(scrRect);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return bufImg;
	}
}

class PaintCanvas extends JPanel {
	private ScreenCapture screen = null;

	private BufferedImage scrImg = null;

	public PaintCanvas(ScreenCapture screen) {
		this.screen = screen;
	}

	protected void paintComponent(Graphics g) {
		// TODO Auto-generated method stub
		// BufferedImage scrImg = screen.captureScreen();
		if (scrImg != null) {
			int iWidth = this.getWidth();
			int iHeight = this.getHeight();
			g.drawImage(scrImg, 0, 0, iWidth, iHeight, 0, 0, scrImg.getWidth(),
					scrImg.getHeight(), null);
		}

	}

	public void drawScreen() {
		Graphics g = this.getGraphics();
		scrImg = screen.captureScreen();
		if (scrImg != null) {
			this.paintComponent(g);
		}
		g.dispose();
	}

}

public class ScreenCaptureMainClass extends JFrame implements ActionListener {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * @param args
	 */
	private ScreenCapture scrCapture = null;

	private PaintCanvas canvas = null;

	public ScreenCaptureMainClass() {
		super("Screen Capture");
		init();
	}

	public void actionPerformed(ActionEvent e) {
		canvas.drawScreen();
	}

	private void init() {
		scrCapture = new ScreenCapture();
		canvas = new PaintCanvas(scrCapture);
		Container c = this.getContentPane();
		c.setLayout(new BorderLayout());
		c.add(canvas, BorderLayout.CENTER);
		JButton capButton = new JButton("×¥ÆÁ");
		c.add(capButton, BorderLayout.SOUTH);
		capButton.addActionListener(this);
		this.setSize(400, 400);
		this.setVisible(true);
		this.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		new ScreenCaptureMainClass();
	}

}