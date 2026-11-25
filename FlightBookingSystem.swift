import Foundation
struct Passenger {
    let bookingID: String
    let name: String
    let seatNumber: String
    let ticketPrice: Double
}

class Flight {
    let flightNumber: String
    let destination: String
    private var availableSeats: Set<String>
    private var bookings: [String: Passenger] = [:]
    
    init(flightNumber: String, destination: String, seats: [String]) {
        self.flightNumber = flightNumber
        self.destination = destination
        self.availableSeats = Set(seats)
    }
    
    func bookSeat(passengerName: String, seatNumber: String, price: Double) {
        let seat = seatNumber.uppercased()
        guard availableSeats.contains(seat) else {
            print("Booking Failed: Seat \(seat) is unavailable or does not exist.")
            return
        }
        
        let bookingID = "BK-\(Int.random(in: 100...999))"
        let passenger = Passenger(bookingID: bookingID, name: passengerName, seatNumber: seat, ticketPrice: price)
        
        availableSeats.remove(seat)
        bookings[bookingID] = passenger
        print("Confirmed: \(passengerName) booked Seat \(seat) on Flight \(flightNumber) (ID: \(bookingID)).")
    }
    
    func cancelBooking(bookingID: String) {
        guard let passenger = bookings.removeValue(forKey: bookingID) else {
            print("Cancellation Failed: Booking ID \(bookingID) not found.")
            return
        }
        
        availableSeats.insert(passenger.seatNumber)
        let refund = passenger.ticketPrice * 0.80 // 80% refund policy
        print("Cancelled Booking \(bookingID) for \(passenger.name). Seat \(passenger.seatNumber) released. Refund: $\(String(format: "%.2f", refund))")
    }
    
    func printManifest() {
        print("\n--- Flight \(flightNumber) to \(destination) ---")
        print("Available Seats: \(availableSeats.sorted().joined(separator: ", "))")
        print("Confirmed Passengers:")
        if bookings.isEmpty {
            print("  No passengers booked yet.")
        } else {
            for (_, p) in bookings {
                print("  [\(p.bookingID)] \(p.name) - Seat \(p.seatNumber) ($\(String(format: "%.2f", p.ticketPrice)))")
            }
        }
        print("------------------------------------------\n")
    }
}

// Example Usage
let flight = Flight(flightNumber: "AI-702", destination: "Bengaluru", seats: ["1A", "1B", "2A", "2B"])
flight.bookSeat(passengerName: "Spandan Das", seatNumber: "1A", price: 150.0)
flight.bookSeat(passengerName: "Aarav Sen", seatNumber: "2B", price: 150.0)
flight.printManifest()
