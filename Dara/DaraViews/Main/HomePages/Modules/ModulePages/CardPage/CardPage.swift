//
//  CardPage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 27.05.2024.
//

import SwiftUI

struct CardPage: View {
    @StateObject var viewModel: CardViewModel
    @StateObject var modulePagesViewModel: ModulePagesViewModel
    
    var body: some View {
        if modulePagesViewModel.isLoading {
            LoaderView()
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            modulePagesViewModel.router.dismissScreenStack()
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                }
        } else {
            ZStack {
                VStack(spacing: 16) {
                    ZStack (alignment: .leading) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 342, height: 16)
                            .background(Color(red: 0.97, green: 0.97, blue: 0.95))
                            .cornerRadius(12)
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(
                                width: (modulePagesViewModel.getLineWidth()),
                                height: 16
                            )
                            .background(Color(red: 0, green: 0.67, blue: 0.76))
                            .cornerRadius(12)
                    }
                    
                    Text("\(modulePagesViewModel.currentTask-1)/\(modulePagesViewModel.allTasks)")
                    
                    Spacer()
                    
                    Button {
                        modulePagesViewModel.getPages()
                    } label: {
                        if modulePagesViewModel.currentPage > modulePagesViewModel.allPages {
                            ButtonView(buttonType: .finish)
                        } else {
                            ButtonView(buttonType: .continue)
                        }
                    }
                }
                
                VStack (spacing: 32) {
                    CardsForWords(title: viewModel.data.title, translate: viewModel.data.translation.title, image: viewModel.image)
                    
                    if viewModel.data.audio != "" {
                        Image(systemName: "speaker.wave.2")
                            .resizable()
                            .frame( width: 25, height: 20)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(Colors.black)
                            )
                            .onTapGesture {
                                SoundManager.instance.playAudio(audioData: viewModel.audioData)
                            }
                    }
                    
                }
            }
            .blur(radius: modulePagesViewModel.isLoading ? 3 : 0)
            .padding(24)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        modulePagesViewModel.router.dismissScreenStack()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    
                }
            }
        }
    }
}

//#Preview {
//    CardPage()
//}
