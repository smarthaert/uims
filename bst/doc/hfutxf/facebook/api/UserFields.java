package com.hfutxf.facebook.api;

public enum UserFields {
	UID("uid"),NAME("name"),LOCALE("name"),PIC_SQUARE("pic_square"),SEX("sex");
	private String name;
	private UserFields(String name){this.name = name;}
	@Override public String toString(){return this.name;}		
}
