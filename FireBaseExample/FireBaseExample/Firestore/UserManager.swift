//
//  UserManager.swift
//  FireBaseExample
//
//  Created by Taewon Yoon on 4/13/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

struct DBUser: Codable {
    let userId: String
    let dateCreated: Date?
    let email: String?
    let isPremium: Bool?
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.email = auth.email
        self.dateCreated = Date()
        self.isPremium = false
    }
    
    init(userId: String, dateCreated: Date? = nil, email: String? = nil, isPremium: Bool? = nil) {
        self.userId = userId
        self.email = email
        self.dateCreated = dateCreated
        self.isPremium = isPremium
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case dateCreated = "is_anonymous"
        case email = "email"
        case isPremium = "user_isPremium" // DB에 저장되어 있는 이름
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.isPremium, forKey: .isPremium)
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.isPremium = try container.decodeIfPresent(Bool.self, forKey: .isPremium)
    }
}

final class UserManager {
    
    static let shared = UserManager()
    private init() { }
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false)
    }
    
    func getUser(userId: String) async throws -> DBUser {
        try await userDocument(userId: userId).getDocument(as: DBUser.self)
    }
    
    func updateUserPremiumStatus(userId: String, isPremium: Bool) {
        let data: [String:Any] = [
            DBUser.CodingKeys.isPremium.rawValue : isPremium
        ]
        // 해당 필드만 값을 바꿀 수 있다
        userDocument(userId: userId).updateData(data)
    }
}
