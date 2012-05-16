package com.concurrent;

import java.util.concurrent.Callable;
import java.util.concurrent.CompletionService;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorCompletionService;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

public class TestCompletionService {
	public static void main(String[] args) throws InterruptedException,
			ExecutionException {
		ExecutorService exec = Executors.newFixedThreadPool(10);
		CompletionService serv = new ExecutorCompletionService(exec);

		for (int index = 0; index < 5; index++) {
			final int NO = index;
			Callable downImg = new Callable() {
				public String call() throws Exception {
					Thread.sleep((long) (Math.random() * 10000));
					return "Downloaded Image " + NO;
				}
			};
			serv.submit(downImg);
		}

		Thread.sleep(1000 * 2);
		System.out.println("Show web content");
		for (int index = 0; index < 5; index++) {
			Future task = serv.take();

			String img = (String) task.get();
			System.out.println(img);
		}

		System.out.println("End");
		// 关闭线程池
		exec.shutdown();
	}
}