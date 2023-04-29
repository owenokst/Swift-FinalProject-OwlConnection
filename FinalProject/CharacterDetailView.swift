//
//  CharacterDetailView.swift
//  FinalProject
//
//  Created by Owen Okst on 4/23/23.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    @State private var nameColor: Color = .black
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(character.name)
                .font(Font.custom("harryp", size: 75))
                .foregroundColor(nameColor)
                .bold()
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
            
            // image
            
            AsyncImage(url: URL(string: character.image)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .background(.white)
                        .frame(width: 145, height: 190)
                        .cornerRadius(16)
                        .shadow(radius: 8, x: 5, y: 5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.gray.opacity(0.5), lineWidth: 1)
                        }
                        .padding(.trailing)
                } else if character.image == "" {
                    Image(systemName: "questionmark.square.dashed")
                        .resizable()
                        .scaledToFill()
                        .background(.white)
                        .frame(width: 200, height: 200)
                        .cornerRadius(16)
                        .shadow(radius: 8, x: 5, y: 5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.gray.opacity(0.5), lineWidth: 1)
                        }
                        .padding(.trailing)
                } else {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 200, height: 200)
                        .padding(.trailing)
                }
            }
            Group {
                HStack {
                    Text("Species:")
                        .foregroundColor(nameColor)
                    Text(character.species)
                }
                HStack {
                    Text("House:")
                        .foregroundColor(nameColor)
                    Text(character.house)
                }
                HStack {
                    Text("Ancestry:")
                        .foregroundColor(nameColor)
                    Text(character.ancestry)
                }
                HStack {
                    Text("Eye Color:")
                        .foregroundColor(nameColor)
                    Text(character.eyeColour)
                }
                HStack {
                    Text("Hair Color:")
                        .foregroundColor(nameColor)
                    Text(character.hairColour)
                }
                HStack {
                    Text("Actor:")
                        .foregroundColor(nameColor)
                    Text(character.actor)
                }
            }
            .font(Font.custom("harryp", size: 40))
            
            
            
            Spacer()
        }
        .padding()
        .onAppear {
            if character.house == "Gryffindor" {
                nameColor = .red
            } else if character.house == "Hufflepuff" {
                nameColor = .yellow
            } else if character.house == "Slytherin" {
                nameColor = .green
            } else if character.house == "Ravenclaw" {
                nameColor = .blue
            } else {
                nameColor = .black
            }
        }
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(character: Character(name: "Harry Potter", species: "Human", house: "Gryffindor", ancestry: "half-blood", eyeColour: "green", hairColour: "black", actor: "Daniel Radcliffe", image: "https://ik.imagekit.io/hpapi/harry.jpg"))
    }
}
