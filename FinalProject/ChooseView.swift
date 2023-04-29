//
//  ChooseView.swift
//  FinalProject
//
//  Created by Owen Okst on 4/22/23.
//

import SwiftUI
import Firebase

struct ChooseView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    ListView()
                } label: {
                    Text("Characters")
                }
                .scaleEffect(2)
                .frame(width: 200, height: 150)
                NavigationLink {
                    HouseDetailView()
                } label: {
                    Text("Sorting Hat")
                }
                .scaleEffect(2)
                .frame(width: 200, height: 150)

                NavigationLink {
                    PostListView()
                } label: {
                    Text("Hoot Hoot")
                }
                .scaleEffect(2)
                .frame(width: 200, height: 150)

            }
            .font(Font.custom("harryp", size: 40))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Sign Out") {
                        do {
                            try Auth.auth().signOut()
                            print("logout successful")
                            dismiss()
                        } catch {
                            print("Error could not sign out")
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .buttonStyle(.borderedProminent)
        .tint(.black)
    }
}

struct ChooseView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseView()
    }
}
