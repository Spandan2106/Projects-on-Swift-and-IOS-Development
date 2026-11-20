import Foundation

struct Expense {
    var title: String
    var amount: Double
    var category: String
}

class ExpenseTracker {
    var expenses: [Expense] = []

    func addExpense() {
        print("Enter expense title: ")
        let title = readLine() ?? ""

        print("Enter amount: ")
        let amount = Double(readLine() ?? "") ?? 0

        print("Enter category: ")
        let category = readLine() ?? ""

        expenses.append(Expense(title: title, amount: amount, category: category))
        print("Expense added successfully!")
    }

    func displayExpenses() {
        if expenses.isEmpty {
            print("No expenses recorded.")
            return
        }

        print("\n--- Expense List ---")
        for expense in expenses {
            print("Title: \(expense.title) | Amount: ₹\(expense.amount) | Category: \(expense.category)")
        }
    }

    func showTotal() {
        let total = expenses.reduce(0) { $0 + $1.amount }
        print("Total Expenses: ₹\(total)")
    }

    func searchByCategory() {
        print("Enter category to search: ")
        let category = readLine() ?? ""

        let filtered = expenses.filter {
            $0.category.lowercased() == category.lowercased()
        }

        if filtered.isEmpty {
            print("No expenses found in this category.")
        } else {
            for expense in filtered {
                print("\(expense.title) - ₹\(expense.amount)")
            }
        }
    }
}

let tracker = ExpenseTracker()

while true {
    print("""

    ===== EXPENSE TRACKER =====
    1. Add Expense
    2. Display Expenses
    3. Show Total Expenses
    4. Search by Category
    5. Exit
    """)

    print("Enter choice: ")
    let choice = Int(readLine() ?? "") ?? 0

    switch choice {
    case 1:
        tracker.addExpense()
    case 2:
        tracker.displayExpenses()
    case 3:
        tracker.showTotal()
    case 4:
        tracker.searchByCategory()
    case 5:
        print("Exiting Expense Tracker.")
        break
    default:
        print("Invalid choice.")
    }

    if choice == 5 {
        break
    }
}
