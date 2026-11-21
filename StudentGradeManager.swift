import Foundation

struct Student {
    var name: String
    var rollNumber: Int
    var marks: [Double]
    var total: Double {
        marks.reduce(0, +)
    }
    var percentage: Double {
        total / Double(marks.count)
    }
    var grade: String {
        switch percentage {
        case 90...: return "A+"
        case 80..<90: return "A"
        case 70..<80: return "B"
        case 60..<70: return "C"
        case 50..<60: return "D"
        default: return "F"
        }
    }
}
class StudentManager {
    private var students: [Student] = []
    func addStudent() {
        print("Enter student name:")
        guard let name = readLine(), !name.isEmpty else {
            print("Invalid name.")
            return
        }
        print("Enter roll number:")
        guard let roll = Int(readLine() ?? "") else {
            print("Invalid roll number.")
            return
        }
        if students.contains(where: { $0.rollNumber == roll }) {
            print("Roll number already exists.")
            return
        }
        var marks: [Double] = []
        for i in 1...5 {
            print("Enter marks for subject \(i):")
            guard let mark = Double(readLine() ?? ""),
                  (0...100).contains(mark) else {
                print("Invalid marks.")
                return
            }
            marks.append(mark)
        }
        let student = Student(
            name: name,
            rollNumber: roll,
            marks: marks
        )
        students.append(student)
        print("Student added successfully.")
    }
    func displayStudents() {
        if students.isEmpty {
            print("No students available.")
            return
        }
        for student in students {
            print("\nName: \(student.name)")
            print("Roll Number: \(student.rollNumber)")
            print("Total: \(student.total)")
            print("Percentage: \(student.percentage)%")
            print("Grade: \(student.grade)")
        }
    }

    func searchStudent() {
        print("Enter roll number:")

        guard let roll = Int(readLine() ?? "") else {
            print("Invalid roll number.")
            return
        }

        if let student = students.first(where: {
            $0.rollNumber == roll
        }) {
            print("\nName: \(student.name)")
            print("Percentage: \(student.percentage)%")
            print("Grade: \(student.grade)")
        } else {
            print("Student not found.")
        }
    }
}

let manager = StudentManager()

while true {
    print("""

    ===== STUDENT GRADE MANAGER =====
    1. Add Student
    2. Display All Students
    3. Search Student
    4. Exit
    """)

    print("Enter choice:")

    switch readLine() {
    case "1":
        manager.addStudent()

    case "2":
        manager.displayStudents()

    case "3":
        manager.searchStudent()

    case "4":
        print("Exiting...")
        exit(0)

    default:
        print("Invalid choice.")
    }
}
