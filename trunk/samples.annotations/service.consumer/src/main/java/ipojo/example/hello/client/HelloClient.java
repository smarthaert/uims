package ipojo.example.hello.client;

import org.apache.felix.ipojo.annotations.Component;
import org.apache.felix.ipojo.annotations.Invalidate;
import org.apache.felix.ipojo.annotations.Requires;
import org.apache.felix.ipojo.annotations.Validate;

import ipojo.example.hello.Hello;

@Component(name = "AnnotedHelloClient", immediate = true)
public class HelloClient implements Runnable {

	@Requires
	private Hello[] m_hello; // Service Dependency

	private final static int DELAY = 10000;
	private boolean end;

	public void run() {
		while (!end) {
			try {
				invoke();
				Thread.sleep(DELAY);
			} catch (InterruptedException ie) {
			}
			/* will recheck end */
		}
	}

	public void invoke() {
		for (int i = 0; i < m_hello.length; i++) {
			System.out.println(m_hello[i].sayHello("Clement"));
		}
	}

	@Validate
	public void starting() {
		Thread T = new Thread(this);
		end = false;
		T.start();
	}

	@Invalidate
	public void stopping() {
		end = true;
	}
}