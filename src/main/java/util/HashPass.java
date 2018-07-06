package util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class HashPass {
	public String password(String pass) throws IOException, NoSuchAlgorithmException {
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		String hash_password = "";
		byte[] hash = null;
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		hash = md.digest(pass.getBytes());
		for (byte b : hash) {
			hash_password += String.format("%02X", b);
		}
		return hash_password;
	}
}
