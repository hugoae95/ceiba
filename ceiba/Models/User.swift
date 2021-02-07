class User: Codable {
    
    let id: Int
    let name, email, phone: String

    enum CodingKeys: String, CodingKey {
        case id, name, email, phone
    }

    init(id: Int, name: String, email: String, phone: String) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
    }
}
