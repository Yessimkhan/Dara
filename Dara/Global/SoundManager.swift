//
//  SoundManager.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 09.04.2024.
//

import AVKit
class SoundManager: NSObject, AVAudioPlayerDelegate {
    
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case sad
        case success
    }
    
    func playSound(sound: SoundOption){
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3")else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playAudio(audioData: Data?) {
            guard let data = audioData, !data.isEmpty else {
                print("Audio data is nil or empty")
                return
            }

            do {
                player = try AVAudioPlayer(data: data, fileTypeHint: ".m4a")
                player?.delegate = self  // Correctly assigning delegate
                player?.prepareToPlay()
                player?.play()
            } catch {
                print("Failed to initialize player with data: \(error.localizedDescription)")
            }
        }
    
}
