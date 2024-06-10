//
//  AudioPlayerView.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 05.06.2024.
//

import SwiftUI
import AVFoundation

struct AudioPlayerView: View {
    
    @Binding var data: Data?
    @State var isLoading: Bool = true
    @Binding var isPlaying: Bool
    @State private var totalTime: Double = 0.0
    @State private var currentTime: Double = 0.0
    @State private var player: AVAudioPlayer?
    
    var body: some View {
        HStack (spacing: 24) {
            if !isLoading {
                Image(systemName: (isPlaying ? "pause.circle" : "play.circle"))
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Colors.brandPrimary)
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        withAnimation {
                            isPlaying ? pause() : play()
                        }
                    }
            } else {
                MiniLoaderView()
                    .frame(width: 30, height: 30)
            }
            Slider(value: $currentTime, in: 0.0...totalTime) { _ in
                seekAudio(to: currentTime)
            }
        }
        .onAppear(perform: {
            setupAudio(audioData: data)
        })
        .onChange(of: data, {
            setupAudio(audioData: data)
            withAnimation {
                isLoading = false
            }
        })
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect(), perform: { _ in
            updateProgress()
        })
    }
    
    func setupAudio(audioData: Data?) {
        guard let data = audioData, !data.isEmpty else {
            print("Audio data is nil or empty")
            return
        }
        do {
            player = try AVAudioPlayer(data: data, fileTypeHint: AVFileType.m4a.rawValue)
            player?.prepareToPlay()
            totalTime = player?.duration ?? 0.0
        } catch {
            print("Failed to initialize player with data: \(error.localizedDescription)")
        }
        
        withAnimation {
            isLoading = false
        }
    }
    
    func play() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch(let error) {
            print(error.localizedDescription)
        }
        isPlaying = true
        player?.play()
    }
    
    func pause() {
        isPlaying = false
        player?.pause()
    }
    
    func updateProgress() {
        guard let player = player else {return}
        withAnimation {
            currentTime = player.currentTime
        }
        if currentTime == 0.0 {
            pause()
        }
    }
    
    func seekAudio(to time: TimeInterval) {
        player?.currentTime = time
    }
}

//struct AudioPlayerView: View {
//    
//    @State var isPlaying: Bool = false
//    let data: Data = Data()
//    
//    var body: some View {
//        AudioPlayerView1(data: data, isPlaying: $isPlaying)
//            .padding(24)
//    }
//}
//
//#Preview {
//    AudioPlayerView()
//}

//pause.circle
//play
