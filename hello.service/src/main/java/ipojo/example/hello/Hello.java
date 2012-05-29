package ipojo.example.hello;

/**
 * Hello Interface.
 * 
 * @author <a href="mailto:dev@felix.apache.org">Felix Project Team</a>
 */
public interface Hello {

	/**
	 * Returns a message like: "Hello $user_name".
	 * 
	 * @param name
	 *            the name
	 * @return the hello message
	 */
	String sayHello(String name);
}