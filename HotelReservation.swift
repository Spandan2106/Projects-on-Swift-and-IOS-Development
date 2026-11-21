import Foundation

struct Room {
    var roomNumber: Int
    var roomType: String
    var price: Double
    var isBooked: Bool
}

class Hotel {
    private var rooms: [Room] = [
        Room(roomNumber: 101, roomType: "Standard", price: 1500, isBooked: false),
        Room(roomNumber: 102, roomType: "Standard", price: 1500, isBooked: false),
        Room(roomNumber: 201, roomType: "Deluxe", price: 2500, isBooked: false),
        Room(roomNumber: 202, roomType: "Deluxe", price: 2500, isBooked: false),
        Room(roomNumber: 301, roomType: "Suite", price: 5000, isBooked: false)
    ]

    private var reservations: [Int: String] = [:]

    func displayRooms() {
        print("\n--- Room List ---")

        for room in rooms {
            let status = room.isBooked ? "Booked" : "Available"
            print("Room: \(room.roomNumber) | Type: \(room.roomType) | Price: ₹\(room.price) | \(status)")
        }
    }

    func bookRoom() {
        print("Enter room number:")
        let roomNumber = Int(readLine() ?? "") ?? 0

        guard let index = rooms.firstIndex(where: { $0.roomNumber == roomNumber }) else {
            print("Room does not exist.")
            return
        }

        if rooms[index].isBooked {
            print("Room is already booked.")
            return
        }

        print("Enter guest name:")
        let name = readLine() ?? ""

        if name.isEmpty {
            print("Guest name cannot be empty.")
            return
        }

        rooms[index].isBooked = true
        reservations[roomNumber] = name

        print("Room booked successfully for \(name).")
    }

    func showReservations() {
        if reservations.isEmpty {
            print("No reservations found.")
            return
        }

        print("\n--- Reservations ---")
        for (roomNumber, guest) in reservations.sorted(by: { $0.key < $1.key }) {
            print("Room: \(roomNumber) | Guest: \(guest)")
        }
    }

    func cancelReservation() {
        print("Enter room number:")
        let roomNumber = Int(readLine() ?? "") ?? 0

        guard let index = rooms.firstIndex(where: { $0.roomNumber == roomNumber }) else {
            print("Room does not exist.")
            return
        }

        if !rooms[index].isBooked {
            print("Room is not booked.")
            return
        }

        rooms[index].isBooked = false
        reservations.removeValue(forKey: roomNumber)

        print("Reservation cancelled successfully.")
    }
}

let hotel = Hotel()

while true {
    print("""

    ===== HOTEL RESERVATION =====
    1. Display Rooms
    2. Book Room
    3. Show Reservations
    4. Cancel Reservation
    5. Exit
    """)

    print("Enter choice:")
    let choice = Int(readLine() ?? "") ?? 0

    switch choice {
    case 1:
        hotel.displayRooms()
    case 2:
        hotel.bookRoom()
    case 3:
        hotel.showReservations()
    case 4:
        hotel.cancelReservation()
    case 5:
        print("Exiting Hotel System.")
    default:
        print("Invalid choice.")
    }

    if choice == 5 {
        break
    }
}
