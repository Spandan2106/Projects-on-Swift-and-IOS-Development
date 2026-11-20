import Foundation

struct Contact {
    var name: String
    var phone: String
    var email: String
}

class ContactBook {
    var contacts: [Contact] = []
    func addContact() {
        print("Enter name: ")
        let name = readLine() ?? ""
        print("Enter phone number: ")
        let phone = readLine() ?? ""
        print("Enter email: ")
        let email = readLine() ?? ""
        contacts.append(Contact(name: name, phone: phone, email: email))
        print("Contact added successfully!")
    }
    func displayContacts() {
        if contacts.isEmpty {
            print("No contacts available.")
            return
        }
        print("\n--- Contact List ---")
        for contact in contacts {
            print("Name: \(contact.name) | Phone: \(contact.phone) | Email: \(contact.email)")
        }
    }

    func searchContact() {
        print("Enter name to search: ")
        let name = readLine() ?? ""

        let found = contacts.filter {
            $0.name.lowercased().contains(name.lowercased())
        }

        if found.isEmpty {
            print("Contact not found.")
        } else {
            for contact in found {
                print("Name: \(contact.name)")
                print("Phone: \(contact.phone)")
                print("Email: \(contact.email)")
            }
        }
    }

    func updateContact() {
        print("Enter name of contact to update: ")
        let name = readLine() ?? ""

        guard let index = contacts.firstIndex(where: {
            $0.name.lowercased() == name.lowercased()
        }) else {
            print("Contact not found.")
            return
        }

        print("Enter new phone number: ")
        let phone = readLine() ?? ""

        print("Enter new email: ")
        let email = readLine() ?? ""

        contacts[index].phone = phone
        contacts[index].email = email

        print("Contact updated successfully!")
    }

    func deleteContact() {
        print("Enter name to delete: ")
        let name = readLine() ?? ""

        guard let index = contacts.firstIndex(where: {
            $0.name.lowercased() == name.lowercased()
        }) else {
            print("Contact not found.")
            return
        }

        contacts.remove(at: index)
        print("Contact deleted successfully!")
    }
}

let book = ContactBook()

while true {
    print("""

    ===== CONTACT BOOK =====
    1. Add Contact
    2. Display Contacts
    3. Search Contact
    4. Update Contact
    5. Delete Contact
    6. Exit
    """)

    print("Enter choice: ")
    let choice = Int(readLine() ?? "") ?? 0

    switch choice {
    case 1:
        book.addContact()
    case 2:
        book.displayContacts()
    case 3:
        book.searchContact()
    case 4:
        book.updateContact()
    case 5:
        book.deleteContact()
    case 6:
        print("Exiting Contact Book.")
        break
    default:
        print("Invalid choice.")
    }

    if choice == 6 {
        break
    }
}
