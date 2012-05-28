---------------------------------------------------------------------------------------
开源社区文档多多，学习，学习～～～
http://www.open-open.com/doc/


---------------------------------------------------------------------------------------
web测试工具列表
http://www.open-open.com/26.htm

http://yp.oss.org.cn/blog/show_resource.php?resource_id=882
OperaDriver是Opera对WebDriver的一个实现。WebDriver就是基于Selenium的一个自动化测试类库，但它不再是运行在浏览器内的JS程序，而是自己可以控制浏览器。WebDriver能够用多种方式来寻找某元素、处理COOKIE、模拟IE对于JavaScript的处理过程等。 
OperaDriver能够驱动浏览器在你的Web页面上运行各种测试，就像一个真正的用户在操作一样。它可以模拟一些动作如：链接点击、输入文字、提交表单，然后生成你网站在预期情况下的运行报告。 
OperaDriver的最终用户模拟，能够确保你的整个堆栈（包括HTML、脚本、样式、嵌入的资源和后台设置）是可以正常运行。并且不需要繁琐的手工测试事务。
https://github.com/operasoftware/operadriver

Watij提供一套基于Watir的纯Java Api用于Web应用程序自动测试。Watij通过一个真实的浏览器来实现自动功能测试。（Watir是一个使用Ruby实现的开源Web自动化测试框架）
http://watij.com/
http://www.ibm.com/developerworks/cn/java/j-lo-watij/


Lobo是一个完全用Java编写的网页浏览器。目标是全力支持HTML 4 ，Javascript和CSS2，直接JavaFX渲染，它的特点快速，完整，易于扩展，功能丰富和很高的安全性。
http://nchc.dl.sourceforge.net/project/xamj/Lobo%20Browser/0.98.4/lobo-distro-0.98.4.zip

---------------------------------------------------------------------------------------
ESB列表
http://www.open-open.com/66.htm

Apache Camel是一个开源的企业应用集成框架。它采用URI来描述各种组件，这样你可以很方便地与各种传输或者消息模块进行交互，比如HTTP、ActiveMQ、JMS、JBI、SCA、MINA或CXF Bus API。这些模块是采用可插拔的方式进行工作的。Apache Camel拥有小巧、依赖少等特点，能够很容易将其集成在各种Java应用中。
http://interview.group.iteye.com/group/wiki/1858-apache-camel


---------------------------------------------------------------------------------------
OSGi列表
http://www.open-open.com/71.htm

Equinox是OSGi R4 core framework的一个实现，一组实现各种可选的OSGI bundle和一些开发基于OSGi技术的系统所需要的基础构件。Eclipse IDE是基于Equinox项目开发的一个典型例子。
http://www.eclipse.org/equinox/

Apache Karaf是一个基于OSGi的运行环境，它提供了一个轻量级的OSGi容器，可以用于部署各种组件和应用程序。它提供了很多的组件和功能用于帮助开发人员更加灵活的部署应用，如:热部署，动态配置，能够集成到操作系统中作为一个服务，提供可扩展的shell 控制台，可使用任意SSH客户端连到Karaf并在控制台中运行命令，提供基于JAAS的安全框架，提供简单的命令来管理多个实例，可以通过控制台创建、删除、启动、停止Karaf实例等。同时Karaf作为一款成熟而且优秀的OSGi运行环境以及容器已经被诸多Apache项目作为基础容器,例如:Apache Geronimo，Apache ServiceMix，Fuse ESB，由此可见Karaf在性能，功能和稳定性上都是个不错的选择。
http://karaf.apache.org/

iPOJO是一个服务器组件运行时，目标在于简化OSGI应用开发。原生支持所有的OSGI活力。给予POJO的概念，应用逻辑开发简单。非功能性的属性在运行时被注入到组件中。
同样看看Felix对iPOJO优点的说明： 
　　1. 组件被作为POJO开发，不需要其他任何东西 
　　2. 组件模块是可扩展的，因此可以自由的适应需要 
　　3. 标准组件模型管理service 供应和service 依赖，所以可以要求其他任何OSGI服务来创建组合服务， 
　　4. iPOJO管理组件实例的生命周期和环境动态 
　　5. iPOJO提供一个强力的组合系统来创建高度动态的应用 
　　6. iPOJO支持注解，xml或者基于Java的API来定义组件 
　　可以看到iPOJO的功能远比之前的几个解决方案要强大，除了支持Declarative Services已经实现的功能外，还提供了强大的注解支持，而且实现了组合系统，这些对于开发大型的复杂应用时非常有用的。
http://felix.apache.org/site/apache-felix-ipojo.html

