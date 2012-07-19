package com.bst.pro;

import com.bst.pro.service.MService;

public class IFTip {
	private MService smsService;
	private MService ifhqService;
	
	private void init() {
		smsService.init();
		ifhqService.init();
	}
	private void shutdown() {
		smsService.shutdown();
		ifhqService.shutdown();
	}
	
	public static void main(String[] args) {
		
	}
}
