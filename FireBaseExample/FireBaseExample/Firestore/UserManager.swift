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

struct Movie: Codable {
    let id: String
    let title: String
    let isPopular: Bool
}

struct DBUser: Codable {
    let userId: String
    let dateCreated: Date?
    let email: String?
    let isPremium: Bool?
    let isAnonymous: Bool?
    let preferences: [String]?
    let favoriteMovie: Movie?
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.email = auth.email
        self.dateCreated = Date()
        self.isPremium = false
        self.isAnonymous = false
        self.preferences = nil
        self.favoriteMovie = nil
    }
    
    init(userId: String, dateCreated: Date? = nil, email: String? = nil, isPremium: Bool? = nil, isAnonymous: Bool? = nil, preferences: [String]? = nil, favoriteMovie: Movie? = nil) {
        self.userId = userId
        self.email = email
        self.dateCreated = dateCreated
        self.isPremium = isPremium
        self.isAnonymous = isAnonymous
        self.preferences = preferences
        self.favoriteMovie = favoriteMovie
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case dateCreated = "is_anonymous"
        case email = "email"
        case isPremium = "user_isPremium" // DB에 저장되어 있는 이름
        case isAnonymous = "isAnonymous" 
        case preferences = "preferences"
        case favoriteMovie = "favorite_movie"
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.isPremium, forKey: .isPremium)
        try container.encodeIfPresent(self.preferences, forKey: .preferences)
        try container.encodeIfPresent(self.favoriteMovie, forKey: .favoriteMovie)
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.isPremium = try container.decodeIfPresent(Bool.self, forKey: .isPremium)
        self.isAnonymous = try container.decodeIfPresent(Bool.self, forKey: .isAnonymous)
        self.preferences = try container.decodeIfPresent([String].self, forKey: .preferences)
        self.favoriteMovie = try container.decodeIfPresent(Movie.self, forKey: .favoriteMovie)
    }
}

final class UserManager {
    
    static let shared = UserManager()
    private init() { }
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
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
        userDocument(userId: userId).updateData(data)
    }
    
    func addUserPreference(userId: String, preference: String) async throws {
        let data: [String: Any] = [ // 기존에 있던 필드에서 합쳐주는 것 (Union 합체))
            DBUser.CodingKeys.preferences.rawValue : FieldValue.arrayUnion([preference])
        ]
        
        try await userDocument(userId: userId).updateData(data)
    }
    
    func removeUserPreference(userId: String, preference: String) async throws {
        let data: [String: Any] = [
            DBUser.CodingKeys.preferences.rawValue : FieldValue.arrayRemove([preference])
        ]
        
        try await userDocument(userId: userId).updateData(data)
    }
    
    func addFavoriteMovie(userId: String, movie: Movie) async throws {
        guard let data = try? encoder.encode(movie) else {
            throw URLError(.badURL)
        }
        let dict: [String:Any] = [
            DBUser.CodingKeys.favoriteMovie.rawValue : data
        ]
        
        try await userDocument(userId: userId).updateData(dict)
    }
    
    func removeFavoriteMovie(userId: String) async throws {
        let data: [String: Any?] = [
            DBUser.CodingKeys.favoriteMovie.rawValue : nil
        ]
        
        try await userDocument(userId: userId).updateData(data as [AnyHashable : Any])
    }
}
