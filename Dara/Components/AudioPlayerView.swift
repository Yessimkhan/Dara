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
    @ObservedObject var viewModel: DialogViewModel
    
    var body: some View {
        HStack (spacing: 24) {
            if !isLoading {
                Button {
                    withAnimation {
                        if !isPlaying {
                            viewModel.stopAllAudio()
                        }
                        isPlaying.toggle()
                    }
                } label: {
                    Image(systemName: (isPlaying ? "pause.circle" : "play.circle"))
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Colors.brandPrimary)
                        .frame(width: 30, height: 30)
                }
            } else {
                MiniLoaderView()
                    .frame(width: 30, height: 30)
            }
            Slider(value: $currentTime, in: 0.0...totalTime) { _ in
                seekAudio(to: currentTime)
            }
        }
        .onChange(of: isPlaying, {
            if isPlaying {
                play()
            } else {
                pause()
            }
        })
        .onChange(of: data, {
            withAnimation {
                isLoading = false
            }
            setupAudio(audioData: data)
        })
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect(), perform: { _ in
            if isPlaying {
                if let player = player {
                    if player.isPlaying {
                        updateProgress(time: player.currentTime)
                    } else {
                        updateProgress(time: totalTime)
                        isPlaying = false
                    }
                }
            }
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
    }
    
    func play() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch(let error) {
            print(error.localizedDescription)
        }
        viewModel.stopAllAudio()
        isPlaying = true
        player?.play()
    }
    
    func pause() {
        isPlaying = false
        player?.pause()
    }
    
    func updateProgress(time: Double) {
        withAnimation(.linear(duration: 0.1)) {
            currentTime = time
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
