import Foundation

struct Product {
    var id: Int
    var name: String
    var price: Double
    var quantity: Int
}

class Inventory {
    private var products: [Product] = []

    func addProduct() {
        print("Enter product ID:")
        let id = Int(readLine() ?? "") ?? 0

        if products.contains(where: { $0.id == id }) {
            print("Product ID already exists.")
            return
        }

        print("Enter product name:")
        let name = readLine() ?? ""

        print("Enter price:")
        let price = Double(readLine() ?? "") ?? 0

        print("Enter quantity:")
        let quantity = Int(readLine() ?? "") ?? 0

        if price <= 0 || quantity < 0 {
            print("Invalid price or quantity.")
            return
        }

        products.append(Product(id: id, name: name, price: price, quantity: quantity))
        print("Product added successfully.")
    }

    func displayProducts() {
        if products.isEmpty {
            print("Inventory is empty.")
            return
        }

        print("\n--- Inventory ---")
        for product in products {
            print("ID: \(product.id) | Name: \(product.name) | Price: ₹\(product.price) | Stock: \(product.quantity)")
        }
    }

    func searchProduct() {
        print("Enter product ID:")
        let id = Int(readLine() ?? "") ?? 0

        if let product = products.first(where: { $0.id == id }) {
            print("Name: \(product.name)")
            print("Price: ₹\(product.price)")
            print("Quantity: \(product.quantity)")
        } else {
            print("Product not found.")
        }
    }

    func updateStock() {
        print("Enter product ID:")
        let id = Int(readLine() ?? "") ?? 0

        guard let index = products.firstIndex(where: { $0.id == id }) else {
            print("Product not found.")
            return
        }

        print("Enter new quantity:")
        let quantity = Int(readLine() ?? "") ?? -1

        if quantity < 0 {
            print("Invalid quantity.")
            return
        }

        products[index].quantity = quantity
        print("Stock updated successfully.")
    }

    func removeProduct() {
        print("Enter product ID:")
        let id = Int(readLine() ?? "") ?? 0

        guard let index = products.firstIndex(where: { $0.id == id }) else {
            print("Product not found.")
            return
        }

        products.remove(at: index)
        print("Product removed successfully.")
    }
}

let inventory = Inventory()

while true {
    print("""

    ===== INVENTORY MANAGEMENT =====
    1. Add Product
    2. Display Products
    3. Search Product
    4. Update Stock
    5. Remove Product
    6. Exit
    """)

    print("Enter choice:")
    let choice = Int(readLine() ?? "") ?? 0

    switch choice {
    case 1:
        inventory.addProduct()
    case 2:
        inventory.displayProducts()
    case 3:
        inventory.searchProduct()
    case 4:
        inventory.updateStock()
    case 5:
        inventory.removeProduct()
    case 6:
        print("Exiting Inventory System.")
    default:
        print("Invalid choice.")
    }

    if choice == 6 {
        break
    }
}
