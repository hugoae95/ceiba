class Post: Codable {
    
    let userId, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userId, id, title, body
    }

    init(userId: Int, id: Int, title: String, body: String) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
}
