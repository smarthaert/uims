package org.hello.client;

import org.apache.felix.ipojo.annotations.Component;
import org.apache.felix.ipojo.annotations.Invalidate;
import org.apache.felix.ipojo.annotations.Property;
import org.apache.felix.ipojo.annotations.Requires;
import org.apache.felix.ipojo.annotations.Validate;

import com.hello.service.Hello;

/**
 * Hello Service simple client.
 * 
 * @author <a href="mailto:dev@felix.apache.org">Felix Project Team</a>
 */
@Component(name="HelloClient")
public class HelloClient implements Runnable {

	/**
	 * Delay between two invocations.
	 */
	private static final int DELAY = 10000;

	/**
	 * Hello services. Injected by the container.
	 * */
	@Requires
	private Hello[] m_hello;

	/**
	 * End flag.
	 * */
	private boolean m_end;
	
	/**
	 * name property.
	 * Injected by the container
	 */
	@Property(name="hello.name")
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
			// Update with your name.
			System.out.println(m_hello[i].sayHello("world"));
		}
	}

	/**
	 * Starting.
	 */
	@Validate
	public void starting() {
		Thread thread = new Thread(this);
		m_end = false;
		thread.start();
	}

	/**
	 * Stopping.
	 */
	@Invalidate
	public void stopping() {
		m_end = true;
	}
}