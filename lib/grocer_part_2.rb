require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    cart.each do |grocery|
      if grocery[:item] === coupon[:item] && grocery[:count] >= coupon[:num]
        
        #make cupon price per item
          new_cost = coupon[:cost]/coupon[:num]
        
        #Set up new discounted item for cart
        coupon_item = {}
        coupon_item[:item] = "#{grocery[:item]} W/COUPON"
        coupon_item[:price] = new_cost
        coupon_item[:clearance] = grocery[:clearance]
        coupon_item[:count] = coupon[:num]
        grocery[:count] = grocery[:count] - coupon_item[:count]
        cart << coupon_item
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |grocery|
    if grocery[:clearance]
      grocery[:price] *= 0.8
      grocery[:price].round(2)
    end
  end
  cart
end


def checkout(cart, coupons)
  total = 0
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  
  cart.each do |grocery|
    total += grocery[:price] * grocery[:count]
  end
  
  if total > 100
    total *= 0.9
  end
  total.round(2)
end
