package Codewars;

public class java1 {

	 public static String createPhoneNumber(int[] numbers) {

/*good 1 */		 
		 // 		return String.format("(%d%d%d) %d%d%d-%d%d%d%d", numbers[0], numbers[1], numbers[2], numbers[3], numbers[4], numbers[5], numbers[6], numbers[7],numbers[8], numbers[9]);
	
		 
/*good 2*/		 
		//		 String phoneNumber = new String("(xxx) xxx-xxxx");
		//		 
		//		 for (int i : numbers) {
		//			 phoneNumber = phoneNumber.replaceFirst("x", Integer.toString(i));
		//		 }
		//		 
		//		 return phoneNumber;
		 
 /*mine*/
		//		 String s ="";   
		//			s+= "(";
		//			for (int i = 0; i < numbers.length; i++) {
		//				s+= numbers[i];
		//    	
		//				if(i == 2) {
		//					s+= ") ";
		//				} else if(i == 5) {
		//					s +="-";
		//				}
		//			}
		//			return s;
		 
		 String phoneNumber = new String ("(xxx) xxx-xxxx");
		 for (int i : numbers) {
			 //System.out.println(i);
			 phoneNumber = phoneNumber.replaceFirst("x", Integer.toString(numbers[i]));
			 //System.out.println(phoneNumber);
		}
		 return phoneNumber;
	 }
	// => returns "(123) 456-7890"
	 
	public static void main(String[] args) {
		int [] x = {7, 2, 3, 4, 5, 6, 7, 8, 9, 0};
		System.out.println(java1.createPhoneNumber(x));
	}
}