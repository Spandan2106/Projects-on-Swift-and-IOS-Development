import Foundation

enum Priority: String, Comparable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
    
    private var rank: Int {
        switch self {
        case .low: return 1
        case .medium: return 2
        case .high: return 3
        }
    }
    
    static func < (lhs: Priority, rhs: Priority) -> Bool {
        return lhs.rank < rhs.rank
    }
}

enum TaskStatus: String {
    case pending = "Pending"
    case inProgress = "In Progress"
    case completed = "Completed"
}

struct WorkTask {
    let id: Int
    var title: String
    var priority: Priority
    var status: TaskStatus
}

class TaskBoard {
    private var tasks: [Int: WorkTask] = [:]
    private var nextID: Int = 1
    
    func createTask(title: String, priority: Priority) {
        let task = WorkTask(id: nextID, title: title, priority: priority, status: .pending)
        tasks[nextID] = task
        print("Created Task #\(nextID): '\(title)' [Priority: \(priority.rawValue)]")
        nextID += 1
    }
    
    func updateStatus(id: Int, newStatus: TaskStatus) {
        guard var task = tasks[id] else {
            print("Error: Task #\(id) not found.")
            return
        }
        task.status = newStatus
        tasks[id] = task
        print("Updated Task #\(id) status to \(newStatus.rawValue).")
    }
    
    func listTasksByPriority() {
        let sortedTasks = tasks.values.sorted { $0.priority > $1.priority }
        print("\n--- Task Board (Sorted by Priority) ---")
        for task in sortedTasks {
            print("#\(task.id) [\(task.priority.rawValue)] \(task.title) -> \(task.status.rawValue)")
        }
        print("---------------------------------------\n")
    }
}

// Example Usage
let board = TaskBoard()
board.createTask(title: "Refactor BankingLedger", priority: .medium)
board.createTask(title: "Fix ATM overdraft bug", priority: .high)
board.createTask(title: "Update README table", priority: .low)
board.updateStatus(id: 2, newStatus: .completed)
board.listTasksByPriority()
