package org.runtime;

public class Order {
	private String cellPhone;

	private String name;
	private String note;

	private String orderId;
	private String pluginId;
	private String pwd;
	private String userName;

	public Order(String pluginId, String orderId, String cellPhone) {
		super();
		this.pluginId = pluginId;
		this.orderId = orderId;
		this.cellPhone = cellPhone;
	}

	public String getCellPhone() {
		return cellPhone;
	}

	public String getOrderId() {
		return orderId;
	}

	public String getPluginId() {
		return pluginId;
	}

	public void setCellPhone(String cellPhone) {
		this.cellPhone = cellPhone;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public void setPluginId(String pluginId) {
		this.pluginId = pluginId;
	}
}
