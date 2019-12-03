package shop;

import java.util.Hashtable;

//장바구니 역활의 기능
public class CartMgr {

	//key : 상품번호(productNo) , value : 주문객체
	private Hashtable<Integer, OrderBean> hCart = 
			new Hashtable<Integer, OrderBean>();
	
	//Cart Add
	public void addCart(OrderBean order) {
		int productNo = order.getProductNo();
		int quantity /*주문수량*/= order.getQuantity();
		if(quantity>0) {
			if(hCart.containsKey(productNo)) {//cart에 주문한 상품이 있는 경우
				//기존에 들어가 있는 주문객체
				OrderBean temp = hCart.get(productNo);
				quantity+=temp.getQuantity();//새로운 주문+기존에 주문 합침.
				order.setQuantity(quantity);//order 객체에 합쳐진 주문수량 setter
				hCart.put(productNo, order);//카트에 다시 저장하면 기존에 주문객체는 덮어쓰기
			}else{//cart에 주문한 상품이 없는 경우
				hCart.put(productNo, order);
			}
		}
	}
	
	//Cart Update
	public void updateCart(OrderBean order) {
		int productNo = order.getProductNo();
		//hCart에 동일한 키값으로 존재한다면 덮어쓰기
		hCart.put(productNo/*오토박싱*/, order);
	}
	
	//Cart Delete
	public void deleteCart(OrderBean order) {
		int productNo = order.getProductNo();
		hCart.remove(productNo);//오토박싱
	}
	
	//Cart List
	public Hashtable<Integer, OrderBean> getCartList(){
		return hCart;
	}
	
}








