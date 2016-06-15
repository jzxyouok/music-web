package com.johnf.app.music;

import java.util.UUID;

import com.johnf.app.music.util.MD5;

public class Test {

	public static void main(String[] args) {		
		System.out.println(UUID.randomUUID().toString());
		System.out.println(MD5.getMD5Code("admin"));
	}

}
