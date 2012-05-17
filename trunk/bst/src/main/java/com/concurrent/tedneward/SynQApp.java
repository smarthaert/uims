package com.concurrent.tedneward;

import java.util.Arrays;
import java.util.List;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.SynchronousQueue;

class Producer1 implements Runnable {
	private BlockingQueue<String> drop;
	List<String> messages = Arrays.asList("Mares eat oats", "Does eat oats",
			"Little lambs eat ivy", "Wouldn't you eat ivy too?");

	public Producer1(BlockingQueue<String> d) {
		this.drop = d;
	}

	public void run() {
		try {
			for (String s : messages)
				drop.put(s);
			drop.put("DONE");
		} catch (InterruptedException intEx) {
			System.out.println("Interrupted! "
					+ "Last one out, turn out the lights!");
		}
	}
}

class Consumer1 implements Runnable {
	private BlockingQueue<String> drop;

	public Consumer1(BlockingQueue<String> d) {
		this.drop = d;
	}

	public void run() {
		try {
			String msg = null;
			while (!((msg = drop.take()).equals("DONE")))
				System.out.println(msg);
		} catch (InterruptedException intEx) {
			System.out.println("Interrupted! "
					+ "Last one out, turn out the lights!");
		}
	}
}

public class SynQApp {
	public static void main(String[] args) {
		BlockingQueue<String> drop = new SynchronousQueue<String>();
		(new Thread(new Producer1(drop))).start();
		(new Thread(new Consumer1(drop))).start();
	}
}