//
//  AlphabetPage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 16.03.2024.
//

import SwiftUI
import SwiftfulRouting

struct AlphabetPage: View {
    
    @StateObject var viewModel: AlphabetViewModel
    
    var body: some View {
        ScrollView (showsIndicators: false){
            VStack (spacing: 16){
                ForEach(viewModel.alphabetArray.indices, id: \.self) { index in
                    HStack (spacing: 60){
                        
                        Image(systemName: "speaker.wave.2")
                            .resizable()
                            .frame( width: 40, height: 32)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(Colors.black)
                            )
                            .onTapGesture {
                                SoundManager.instance.playAudio(audioData: viewModel.audioData[index])
                            }
                        
                        ZStack {
                            HStack (spacing: 16) {
                                Text(String(viewModel.alphabetArray[index]).uppercased())
                                    .font(.system(size: 56, weight: .semibold))
                                    .foregroundStyle(Colors.brandPrimary)
                                Text(String(viewModel.alphabetArray[index]))
                                    .font(.system(size: 56, weight: .semibold))
                                    .foregroundStyle(Colors.brandPrimary)
                            }
                            .frame(width: 150)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(Colors.brandPrimary)
                            )
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Alphabet")
    }
}

//#Preview {
//    RouterView {router in
//        AlphabetPage(router: router, viewModel: AlphabetViewModel(router: <#T##AnyRouter#>, data: <#T##AlphabetResponse#>))
//    }
//}
