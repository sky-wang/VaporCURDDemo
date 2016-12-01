import Vapor

final class Patient: Model {
    
    var id: Node?
    var firstName: String
    var lastName: String
    var exists: Bool = false
    
    init(firstName: String, lastName: String) {
        self.id = nil
        self.firstName = firstName
        self.lastName = lastName
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        firstName = try node.extract("first_name")
        lastName = try node.extract("last_name")
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "first_name": firstName,
            "last_name": lastName
            ])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create("patients") { users in
            users.id()
            users.string("first_name")
            users.string("last_name")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("patients")
    }

}
