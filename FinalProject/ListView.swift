//
//  ListView.swift
//  FinalProject
//
//  Created by Owen Okst on 4/23/23.
//

import SwiftUI

struct ListView: View {
    @StateObject var characterVM = CharacterViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List(characterVM.characters) { character in
                LazyVStack {
                    NavigationLink {
                        CharacterDetailView(character: character)
                    } label: {
                        Text(character.name)
                            .font(Font.custom("harryp", size: 35))
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("The Characters")
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Text("Back")
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            Task {
                await characterVM.getData()
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
