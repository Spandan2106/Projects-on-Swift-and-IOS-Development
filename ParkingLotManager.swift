import Foundation
enum VehicleType: String {
    case bike = "Bike"
    case car = "Car"
    case truck = "Truck"
    var hourlyRate: Double {
        switch self {
        case .bike: return 20.0
        case .car: return 50.0
        case .truck: return 100.0
        }
    }
}
struct ParkingTicket {
    let ticketID: String
    let plateNumber: String
    let vehicleType: VehicleType
    let slotNumber: Int
    let hoursParked: Int
    var totalFee: Double {
        return Double(hoursParked) * vehicleType.hourlyRate
    }
}
class ParkingLot {
    private let totalSlots: Int
    private var occupiedSlots: [Int: ParkingTicket] = [:]
    private var totalRevenue: Double = 0.0 
    init(totalSlots: Int) {
        self.totalSlots = totalSlots
    }  
    func parkVehicle(plateNumber: String, type: VehicleType, hours: Int) {
        guard hours > 0 else {
            print("Error: Parking duration must be at least 1 hour.")
            return
        }
        
        if let availableSlot = (1...totalSlots).first(where: { occupiedSlots[$0] == nil }) {
            let ticketID = "TKT-\(Int.random(in: 1000...9999))"
            let ticket = ParkingTicket(
                ticketID: ticketID,
                plateNumber: plateNumber.uppercased(),
                vehicleType: type,
                slotNumber: availableSlot,
                hoursParked: hours
            )
            occupiedSlots[availableSlot] = ticket
            print("Parked \(type.rawValue) [\(ticket.plateNumber)] at Slot #\(availableSlot). Ticket ID: \(ticketID)")
        } else {
            print("Parking Lot Full: No slots available for \(plateNumber).")
        }
    } 
    func exitVehicle(slotNumber: Int) {
        guard let ticket = occupiedSlots.removeValue(forKey: slotNumber) else {
            print("Error: Slot #\(slotNumber) is already empty or invalid.")
            return
        }
        
        totalRevenue += ticket.totalFee
        print("Vehicle [\(ticket.plateNumber)] exited Slot #\(slotNumber). Fee Collected: $\(String(format: "%.2f", ticket.totalFee))")
    }  
    func displayStatus() {
        print("\n--- Parking Lot Status (\(occupiedSlots.count)/\(totalSlots) Occupied) ---")
        for slot in 1...totalSlots {
            if let ticket = occupiedSlots[slot] {
                print("Slot #\(slot): [\(ticket.vehicleType.rawValue)] \(ticket.plateNumber) (\(ticket.hoursParked) hrs)")
            } else {
                print("Slot #\(slot): Available")
            }
        }
        print("Total Revenue Collected: $\(String(format: "%.2f", totalRevenue))\n")
    }
}// Example Usage
let lot = ParkingLot(totalSlots: 3)
lot.parkVehicle(plateNumber: "WB02AB1234", type: .car, hours: 3)
lot.parkVehicle(plateNumber: "WB06CD5678", type: .bike, hours: 2)
lot.displayStatus()
lot.exitVehicle(slotNumber: 1)
lot.displayStatus()
