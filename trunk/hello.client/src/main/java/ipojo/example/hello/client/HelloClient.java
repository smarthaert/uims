package ipojo.example.hello.client;

import ipojo.example.hello.Hello;

/**
 * Hello Service simple client.
 * 
 * @author <a href="mailto:dev@felix.apache.org">Felix Project Team</a>
 */
public class HelloClient implements Runnable {

	/**
	 * Delay between two invocations.
	 */
	private static final int DELAY = 10000;

	/**
	 * Hello services. Injected by the container.
	 * */
	private Hello[] m_hello; // Service Requirement

	/**
	 * End flag.
	 * */
	private boolean m_end;

	/**
	 * Name property. Injected by the container.
	 * */
	private String m_name;

	/**
	 * Run method.
	 * 
	 * @see java.lang.Runnable#run()
	 */
	public void run() {
		while (!m_end) {
			try {
				invokeHelloServices();
				Thread.sleep(DELAY);
			} catch (InterruptedException ie) {
				/* will recheck end */
			}
		}
	}

	/**
	 * Invoke hello services.
	 */
	public void invokeHelloServices() {
		for (int i = 0; i < m_hello.length; i++) {
			System.out.println(m_hello[i].sayHello(m_name));
		}
	}

	/**
	 * Starting.
	 */
	public void starting() {
		Thread thread = new Thread(this);
		m_end = false;
		thread.start();
	}

	/**
	 * Stopping.
	 */
	public void stopping() {
		m_end = true;
	}
}