require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  cart.each do |cart_item|
    coupons.each do |coupon|
      if coupon[:item] == cart_item[:item]  
        next unless cart_item[:count] >= coupon[:num]
        cart_item[:count] -= coupon[:num]
        cart.push({
          :item => cart_item[:item] + ' W/COUPON',
          :price => (coupon[:cost] / coupon[:num]),
          :count => coupon[:num],
          :clearance => cart_item[:clearance]
        })       
      end
    end
  end

    
  cart  
end

def apply_clearance(cart)
  cart.each do |cart_item|
    next unless cart_item[:clearance]
    cart_item[:price] -= cart_item[:price] * 0.2
  end 
end

def checkout(cart, coupons)
  cons_cart = consolidate_cart(cart)
  coup_cart = apply_coupons(cons_cart, coupons)
  checkout_cart = apply_clearance(coup_cart)
  total = 0
  checkout_cart.each do |item|
    total += (item[:count] * item[:price])
  end
  total >= 100 ? total * 0.9 : total
end