//
//  PostListView.swift
//  FinalProject
//
//  Created by Owen Okst on 4/28/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct PostListView: View {
    @EnvironmentObject var postVM: PostViewModel
    @FirestoreQuery(collectionPath: "posts") var posts: [Post]
    @State private var sheetIsPresented = false
    @Environment(\.dismiss) private var dismiss
    @State private var postColor: Color = .black

    
    var body: some View {
        NavigationStack {
            List {
                ForEach(posts) { post in
                    NavigationLink {
                        PostDetailView(post: post)
                    } label: {
                        Text(post.title)
                            .foregroundColor(postColor)
                    }
                }
                .font(Font.custom("harryp", size: 28))
            }
            
            .listStyle(.plain)
            .navigationTitle("Latest Hoots:")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Back") {
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(.bordered)
                }
            }
            .font(Font.custom("harryp", size: 35))
            .padding(.bottom)
        }
        
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $sheetIsPresented) {
            NavigationStack {
                PostDetailView(post: Post())
            }
        }
    }

}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView()
            .environmentObject(PostViewModel())
    }
}
