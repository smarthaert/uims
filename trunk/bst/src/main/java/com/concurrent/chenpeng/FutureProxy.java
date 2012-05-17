package com.concurrent.chenpeng;

/**
 * <p>Title: LoonFramework</p>
 * <p>Description:利用Future模式进行处理</p>
 * <p>Copyright: Copyright (c) 2007</p>
 * <p>Company: LoonFramework</p>
 * @author chenpeng  
 * @email：ceponline@yahoo.com.cn 
 * @version 0.1
 */
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.ThreadFactory;

public abstract class FutureProxy<T> {

	/**
	 * 负责加载实例
	 * @author Administrator
	 *
	 */
	private final class CallableImpl implements Callable<T> {

		public T call() throws Exception {
			return FutureProxy.this.createInstance();//利用子类的实例化方法
		}
	}

	private static class InvocationHandlerImpl<T> implements InvocationHandler {

		private Future<T> future;

		private volatile T instance;

		InvocationHandlerImpl(Future<T> future) {
			this.future = future;
		}

		public Object invoke(Object proxy, Method method, Object[] args)
				throws Throwable {
			synchronized (this) {
				//判断是否完成实例化
				if (this.future.isDone()) {
					this.instance = this.future.get();
				} else {
					while (!this.future.isDone()) {
						try {
							this.instance = this.future.get();
						} catch (InterruptedException e) {
							Thread.currentThread().interrupt();
						}
					}
				}

				//真正调用被代理的方法
				return method.invoke(this.instance, args);
			}
		}
	}

	/**
	 * 实现java.util.concurrent.ThreadFactory接口
	 * 实现自定义的初始化的特殊线程
	 * @author chenpeng
	 * 
	 */
	private static final class ThreadFactoryImpl implements ThreadFactory {

		public Thread newThread(Runnable r) {
			Thread thread = new Thread(r);
			thread.setDaemon(true);//以后台守护的形式运行
			return thread;
		}
	}

	private static ExecutorService service = Executors
			.newCachedThreadPool(new ThreadFactoryImpl());//CashedThread是按需产生线程，线程开销最小

	protected abstract T createInstance();

	protected abstract Class<? extends T> getInterface();

	/**
	 * 返回代理的实例
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public final T getProxyInstance() {
		Class<? extends T> interfaceClass = this.getInterface();
		if (interfaceClass == null || !interfaceClass.isInterface()) {
			throw new IllegalStateException();
		}

		Callable<T> task = new CallableImpl();//加载实例

		//使用定制的线程池中的线程运行任务（非阻塞）
		Future<T> future = FutureProxy.service.submit(task);

		return (T) Proxy.newProxyInstance(interfaceClass.getClassLoader(),
				new Class<?>[] { interfaceClass }, new InvocationHandlerImpl(
						future));
	}
}