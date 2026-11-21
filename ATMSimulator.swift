import Foundation

class ATM {
    private var balance: Double
    init(balance: Double) {
        self.balance = balance
    }
    func checkBalance() {
        print("Current Balance: ₹\(balance)")
    }
    func deposit() {
        print("Enter deposit amount: ")
        let amount = Double(readLine() ?? "") ?? 0
        if amount > 0 {
            balance += amount
            print("₹\(amount) deposited successfully.")
        } else {
            print("Invalid deposit amount.")
        }
    }
    func withdraw() {
        print("Enter withdrawal amount: ")
        let amount = Double(readLine() ?? "") ?? 0
        if amount <= 0 {
            print("Invalid amount.")
        } else if amount > balance {
            print("Insufficient balance.")
        } else {
            balance -= amount
            print("₹\(amount) withdrawn successfully.")
        }
    }
}

let atm = ATM(balance: 10000)
while true {
    print("""

    ===== ATM MENU =====
    1. Check Balance
    2. Deposit Money
    3. Withdraw Money
    4. Exit
    """)   
    print("Enter choice: ")
    let choice = Int(readLine() ?? "") ?? 0

    switch choice {
    case 1:
        atm.checkBalance()
    case 2:
        atm.deposit()
    case 3:
        atm.withdraw()
    case 4:
        print("Thank you for using the ATM.")
        break
    default:
        print("Invalid choice.")
    }
    if choice == 4 {
        break
    }
}
