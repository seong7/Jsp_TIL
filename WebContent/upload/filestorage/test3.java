package Codewars;

import java.text.SimpleDateFormat;

public class test {
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd (E)");
	
	public static void main(String[]args) {
		test y = new test();
		String x = 	y.sdf.format("2019-11-19");
		System.out.println(x);
		System.out.println("gg");
		System.out.println("гого");
	}
}
