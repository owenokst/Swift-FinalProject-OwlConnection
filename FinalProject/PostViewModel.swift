//
//  PostViewModel.swift
//  FinalProject
//
//  Created by Owen Okst on 4/28/23.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

@MainActor
class PostViewModel: ObservableObject {
    @Published var post = Post()
    
    func savePost(post: Post) async -> String? {
        let db = Firestore.firestore()
        if let id = post.id {
            do {
                try await db.collection("posts").document(id).setData(post.dictionary)
                print("😎 Data updated successfully!")
                return post.id
            } catch {
                print("😡 ERROR: Could not update data in 'posts' \(error.localizedDescription)")
                return nil
            }
        } else { // no id? Then this must be new
            do {
                let docRef = try await db.collection("posts").addDocument(data: post.dictionary)
                print("🐣 Data added successfully!")
                return docRef.documentID
            } catch {
                print("😡 ERROR: Could not create a new post in 'posts' \(error.localizedDescription)")
                return nil
            }
        }
    }
    
    func deleteData(post: Post) async {
        let db = Firestore.firestore()
        guard let id = post.id else {
            print("id is nil")
            return
        }
        
        do {
            try await db.collection("posts").document(id).delete()
            print("document successfully removed")
            return
        } catch {
            print("Error removing document \(error.localizedDescription)")
            return
        }
    }
    
    
}


