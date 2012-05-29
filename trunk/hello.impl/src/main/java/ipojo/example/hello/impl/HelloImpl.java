package ipojo.example.hello.impl;

/** 
 * Component implementing the Hello service. 
 * @author <a href="mailto:dev@felix.apache.org">Felix Project Team</a> 
 */
import ipojo.example.hello.Hello;

public class HelloImpl implements Hello {

	/**
	 * Returns an 'Hello' message.
	 * 
	 * @param name
	 *            : name
	 * @return Hello message
	 * @see ipojo.example.hello.Hello#sayHello(java.lang.String)
	 */
	public String sayHello(String name) {
		return "hello " + name;
	}
}