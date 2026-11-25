import Foundation

struct Product {
    let id: String
    let name: String
    let price: Double
}

struct CartItem {
    let product: Product
    var quantity: Int
    var subtotal: Double {
        return product.price * Double(quantity)
    }
}

class ShoppingCart {
    private var items: [String: CartItem] = [:]
    private var discountPercentage: Double = 0.0
    
    func addItem(product: Product, quantity: Int) {
        guard quantity > 0 else {
            print("Error: Quantity must be greater than zero.")
            return
        }
        
        if var existing = items[product.id] {
            existing.quantity += quantity
            items[product.id] = existing
        } else {
            items[product.id] = CartItem(product: product, quantity: quantity)
        }
        print("Added \(quantity)x \(product.name) to cart.")
    }
    
    func removeItem(productID: String) {
        if let removed = items.removeValue(forKey: productID) {
            print("Removed \(removed.product.name) from cart.")
        } else {
            print("Error: Item not found in cart.")
        }
    }
    
    func applyCoupon(code: String) {
        switch code.uppercased() {
        case "SWIFT10":
            discountPercentage = 10.0
            print("Coupon SWIFT10 applied (10% off).")
        case "DEV25":
            discountPercentage = 25.0
            print("Coupon DEV25 applied (25% off).")
        default:
            print("Invalid coupon code.")
        }
    }
    
    func checkout() {
        guard !items.isEmpty else {
            print("Cart is empty. Nothing to checkout.")
            return
        }
        
        print("\n=== Checkout Receipt ===")
        var rawTotal = 0.0
        for (_, item) in items {
            print("\(item.product.name) (x\(item.quantity)) - $\(String(format: "%.2f", item.subtotal))")
            rawTotal += item.subtotal
        }
        
        let discountAmount = rawTotal * (discountPercentage / 100.0)
        let finalTotal = rawTotal - discountAmount
        
        print("------------------------")
        print("Subtotal: $\(String(format: "%.2f", rawTotal))")
        print("Discount (\(Int(discountPercentage))%): -$\(String(format: "%.2f", discountAmount))")
        print("Final Total: $\(String(format: "%.2f", finalTotal))")
        print("========================\n")
        
        items.removeAll()
        discountPercentage = 0.0
    }
}

// Example Usage
let laptop = Product(id: "P01", name: "MacBook Air", price: 999.0)
let mouse = Product(id: "P02", name: "Wireless Mouse", price: 49.0)

let cart = ShoppingCart()
cart.addItem(product: laptop, quantity: 1)
cart.addItem(product: mouse, quantity: 2)
cart.applyCoupon(code: "SWIFT10")
cart.checkout()
