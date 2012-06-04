package ipojo.example.hello.impl;

import ipojo.example.hello.Hello;

import org.apache.felix.ipojo.annotations.Component;
import org.apache.felix.ipojo.annotations.Provides;

/**
 * Component implementing the Hello service.
 **/
@Component
@Provides
public class HelloImpl implements Hello {
	public String sayHello(String name) {
		return "hello " + name;
	}
}