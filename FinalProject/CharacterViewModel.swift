//
//  CharacterViewModel.swift
//  FinalProject
//
//  Created by Owen Okst on 4/23/23.
//

import Foundation

@MainActor
class CharacterViewModel: ObservableObject {
    @Published var characters: [Character] = []
    
    
    
    func getData() async {
                
        let urlString = "https://hp-api.onrender.com/api/characters"
        print("We are accessing the url \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("ERROR: could not convert \(urlString) to a URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            do {
                let characters = try JSONDecoder().decode(Array<Character>.self, from: data)
                print("JSON returned: \n\(self.characters)")
                self.characters = self.characters + characters
            } catch {
                print("JSON ERROR: could not decode returned JSON data \(error.localizedDescription)")
            }
        } catch {
            print("ERROR: could not get data from")
        }
    }
    
}
