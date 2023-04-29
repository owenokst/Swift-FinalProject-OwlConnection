//
//  PostDetailView.swift
//  FinalProject
//
//  Created by Owen Okst on 4/26/23.
//

import SwiftUI
import Firebase


struct PostDetailView: View {
    @EnvironmentObject var postVM: PostViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State var postedByThisUser = true
    
    @State var post: Post
    @State private var isDisabled = true
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("Send a Hoot:")
                    .font(.largeTitle)
                    .padding(.bottom)
                Text("Hoot Title")
                    .font(.title)
                TextField("title", text: $post.title)
                    .autocorrectionDisabled()
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom)
                    .disabled(postedByThisUser)
                Text("Body:")
                    .font(.title)
                TextField("enter hoot here", text: $post.body)
                    .autocorrectionDisabled()
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom)
                    .disabled(postedByThisUser)
                Text("Favorite Movie:")
                    .font(.title)
                TextField("favorite movie", text: $post.movie)
                    .autocorrectionDisabled()
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom)
                    .disabled(postedByThisUser)
            }
            Text("Favorite Character:")
                .font(.title)
            TextField("favorite character", text: $post.character)
                .autocorrectionDisabled()
                .textFieldStyle(.roundedBorder)
                .padding(.bottom)
            HStack {
                Text("Your House:")
                    .font(.title)
                Picker("", selection: $post.house) {
                    ForEach(YourHouse.allCases, id: \.self) {
                        house in
                        Text(house.rawValue)
                            .tag(house.rawValue)
                    }
                }
                .disabled(postedByThisUser)
            }
            
            Spacer()
        }
        .onAppear {
            if post.poster == Auth.auth().currentUser?.email {
                postedByThisUser = false
            }
        }
        .padding()
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    Task {
                        let id = await postVM.savePost(post: post)
                        if id != nil { // save worked!
                            post.id = id
                            dismiss()
                            print(postVM.post.house)
                        } else { // did not save
                            print("😡 DANG! Error saving!")
                        }
                    }
                }
                .disabled(post.title.isEmpty || post.body.isEmpty || post.house.isEmpty ? true : false)
            }
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PostDetailView(post: Post(body: "hello there"))
                .environmentObject(PostViewModel())
        }
    }
}
