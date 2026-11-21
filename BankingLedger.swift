import Foundation

enum TransactionType {
    case deposit
    case withdrawal
}

struct Transaction {
    var type: TransactionType
    var amount: Double
    var description: String
}

class BankAccount {
    private var balance: Double = 0
    private var transactions: [Transaction] = []

    func deposit() {
        print("Enter amount to deposit:")
        let amount = Double(readLine() ?? "") ?? 0

        if amount <= 0 {
            print("Invalid amount.")
            return
        }

        balance += amount
        transactions.append(Transaction(type: .deposit, amount: amount, description: "Deposit"))

        print("Deposit successful.")
    }

    func withdraw() {
        print("Enter amount to withdraw:")
        let amount = Double(readLine() ?? "") ?? 0

        if amount <= 0 {
            print("Invalid amount.")
        } else if amount > balance {
            print("Insufficient balance.")
        } else {
            balance -= amount
            transactions.append(Transaction(type: .withdrawal, amount: amount, description: "Withdrawal"))
            print("Withdrawal successful.")
        }
    }

    func showBalance() {
        print("Current Balance: ₹\(balance)")
    }

    func showTransactions() {
        if transactions.isEmpty {
            print("No transactions recorded.")
            return
        }

        print("\n--- Transaction History ---")

        for (index, transaction) in transactions.enumerated() {
            let type: String

            switch transaction.type {
            case .deposit:
                type = "Deposit"
            case .withdrawal:
                type = "Withdrawal"
            }

            print("\(index + 1). \(type) | ₹\(transaction.amount) | \(transaction.description)")
        }
    }
}

let account = BankAccount()

while true {
    print("""

    ===== BANKING LEDGER =====
    1. Deposit
    2. Withdraw
    3. Check Balance
    4. Transaction History
    5. Exit
    """)

    print("Enter choice:")
    let choice = Int(readLine() ?? "") ?? 0

    switch choice {
    case 1:
        account.deposit()
    case 2:
        account.withdraw()
    case 3:
        account.showBalance()
    case 4:
        account.showTransactions()
    case 5:
        print("Exiting Banking Ledger.")
    default:
        print("Invalid choice.")
    }

    if choice == 5 {
        break
    }
}
