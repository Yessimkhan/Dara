//
//  VariantPage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 23.04.2024.
//

import SwiftUI

struct VariantPage: View {
    @StateObject var viewModel: VariantViewModel
    @StateObject var modulePagesViewModel: ModulePagesViewModel
    
    var body: some View {
        ZStack {
            if modulePagesViewModel.isLoading {
                LoaderView()
                
            } else {
                VStack (spacing: 32) {
                    VStack(spacing: 16){
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
                    }
                    
                    HStack(spacing: 16) {
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
                        
                        VStack(alignment: .leading) {
                            Text("Дұрыс нұсқаны тап.")
                                .font(.system(size: 14, weight: .regular))
                            if modulePagesViewModel.userLanguage == "en" ||  modulePagesViewModel.userLanguage == "us"{
                                Text("Find the correct option.")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundStyle(Colors.buttonInactive)
                            } else {
                                Text("Найдите правильный вариант.")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundStyle(Colors.buttonInactive)
                            }
                        }
                        
                        Spacer()
                    }
                    
                    VStack {
                        Text(viewModel.data.title.replacingOccurrences(of: "\\n", with: "\n"))
                            .font(.system(size: 14, weight: .regular))
                        Text(viewModel.data.translation.title.replacingOccurrences(of: "\\n", with: "\n"))
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(Colors.buttonInactive)
                    }
                    
                    if viewModel.isLoadingImage {
                        LoaderView()
                    } else if let image = viewModel.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 200)
                            .cornerRadius(12)
                    }
                    
                    Spacer()
                    
                    VStack (spacing: 12) {
                        ForEach(viewModel.shuffledVariants, id: \.self) { variant in
                            Button {
                                let isCorrect = viewModel.isCorrectAnswer(variant)
                                if isCorrect {
                                    SoundManager.instance.playSound(sound: .success)
                                    modulePagesViewModel.score += 1
                                    viewModel.router.showModal(transition: .move(edge: .bottom), animation: .easeInOut, alignment: .bottom) {
                                        CorrectView(router: viewModel.router, modulePagesViewModel: modulePagesViewModel)
                                    }
                                } else {
                                    SoundManager.instance.playSound(sound: .sad)
                                    viewModel.router.showModal(transition: .move(edge: .bottom), animation: .easeInOut, alignment: .bottom) {
                                        WrongView(router: viewModel.router, modulePagesViewModel: modulePagesViewModel)
                                    }
                                }
                            } label: {
                                ButtonView(buttonType: .custom, buttonText: variant)
                            }
                        }
                    }
                }
                .padding(24)
                .blur(radius: modulePagesViewModel.isLoading ? 3 : 0)
            }
        }
        .toolbar {
            ToolbarItem (placement: .topBarLeading) {
                Button {
                    print("back button tapped \(modulePagesViewModel.currentPage)")
                    modulePagesViewModel.currentPage -= 1
                    modulePagesViewModel.currentTask -= 1
                    viewModel.router.dismissScreen()
                } label: {
                    Image(systemName: "chevron.left")
                        .fontWeight(.semibold)
                }
            }
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
