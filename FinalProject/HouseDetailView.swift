//
//  HouseDetailView.swift
//  FinalProject
//
//  Created by Owen Okst on 4/24/23.
//

import SwiftUI
import PhotosUI
import AVFAudio

struct HouseDetailView: View {
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedImage: Image = Image(systemName: "person.fill")
    @State private var audioPlayer: AVAudioPlayer!
    let options = ["Griffyndor", "Slytherin", "Ravenclaw", "Hufflepuff"]
    @State private var choosenHouse = ""
    @State private var isShowing = false
    @State private var buttonDisable = false
    
    
    var body: some View {
        VStack(spacing: 1) {
            Image("sortinghat")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
            
            selectedImage
                .resizable()
                .scaledToFit()
                .clipShape(Ellipse())

                
                .padding()
            if !isShowing {
                PhotosPicker(selection: $selectedPhoto, matching: .images, preferredItemEncoding: .automatic) {
                    Image(systemName: "photo.fill.on.rectangle.fill")
                }
                .tint(.black)
                .onChange(of: selectedPhoto) { newValue in
                    Task {
                        do {
                            if let data = try await newValue?.loadTransferable(type: Data.self) {
                                if let uiImage = UIImage(data: data) {
                                    selectedImage = Image(uiImage: uiImage)
                                }
                            }
                        } catch {
                            print("😡 ERROR: loading failed \(error.localizedDescription)")
                        }
                    }
                }
            }

            Spacer()
            if !isShowing {
                Text("Enter your picture")
                    .font(Font.custom("harryp", size: 40))
            }
            if !isShowing {
                Button {
                    isShowing.toggle()
                    let houseIndex = Int.random(in: 0...3)
                    choosenHouse = options[houseIndex]
                    playSound(soundName: "audio\(houseIndex)")
                } label: {
                    Text("Determine My House")
                }
                .font(Font.custom("harryp", size: 30))
                .tint(.black)
                .buttonStyle(.borderedProminent)
            }

            Spacer()
            if isShowing {
                Text(choosenHouse)
                    .font(Font.custom("harryp", size: 90))
                Image("")
            }
            
            Spacer()
        }
        .onAppear {
            playSound(soundName: "hatsound")
        }
        
        .padding(.horizontal)
    }
    func playSound(soundName: String) {
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("Error: could not read file named \(soundName)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print("ERROR")
        }
    }
}


struct HouseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HouseDetailView()
    }
}
