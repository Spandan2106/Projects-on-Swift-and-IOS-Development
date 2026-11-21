import Foundation

struct Book {
    var id: Int
    var title: String
    var author: String
    var isAvailable: Bool
}
class Library {
    private var books: [Book] = []
    func addBook() {
        print("Enter book ID:")
        let id = Int(readLine() ?? "") ?? 0
        if books.contains(where: { $0.id == id }) {
            print("Book ID already exists.")
            return
        }

        print("Enter title:")
        let title = readLine() ?? ""

        print("Enter author:")
        let author = readLine() ?? ""

        books.append(Book(id: id, title: title, author: author, isAvailable: true))
        print("Book added successfully.")
    }

    func displayBooks() {
        if books.isEmpty {
            print("No books available.")
            return
        }

        for book in books {
            let status = book.isAvailable ? "Available" : "Borrowed"
            print("ID: \(book.id) | Title: \(book.title) | Author: \(book.author) | Status: \(status)")
        }
    }

    func searchBook() {
        print("Enter book title:")
        let title = readLine() ?? ""

        let result = books.filter {
            $0.title.lowercased().contains(title.lowercased())
        }

        if result.isEmpty {
            print("Book not found.")
        } else {
            for book in result {
                print("ID: \(book.id) | Title: \(book.title) | Author: \(book.author)")
            }
        }
    }

    func borrowBook() {
        print("Enter book ID:")
        let id = Int(readLine() ?? "") ?? 0

        guard let index = books.firstIndex(where: { $0.id == id }) else {
            print("Book not found.")
            return
        }

        if books[index].isAvailable {
            books[index].isAvailable = false
            print("Book borrowed successfully.")
        } else {
            print("Book is already borrowed.")
        }
    }

    func returnBook() {
        print("Enter book ID:")
        let id = Int(readLine() ?? "") ?? 0

        guard let index = books.firstIndex(where: { $0.id == id }) else {
            print("Book not found.")
            return
        }

        if !books[index].isAvailable {
            books[index].isAvailable = true
            print("Book returned successfully.")
        } else {
            print("Book is already available.")
        }
    }
}

let library = Library()

while true {
    print("""

    ===== LIBRARY MANAGEMENT =====
    1. Add Book
    2. Display Books
    3. Search Book
    4. Borrow Book
    5. Return Book
    6. Exit
    """)

    print("Enter choice:")
    let choice = Int(readLine() ?? "") ?? 0

    switch choice {
    case 1:
        library.addBook()
    case 2:
        library.displayBooks()
    case 3:
        library.searchBook()
    case 4:
        library.borrowBook()
    case 5:
        library.returnBook()
    case 6:
        print("Exiting Library System.")
    default:
        print("Invalid choice.")
    }

    if choice == 6 {
        break
    }
}
