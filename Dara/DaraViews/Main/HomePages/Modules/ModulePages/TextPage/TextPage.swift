//
//  ListenAndRepeatPage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 09.04.2024.
//

import SwiftUI
import SwiftfulRouting
import AVKit

struct TextPage: View {
    @StateObject var viewModel: TextViewModel
    @StateObject var modulePagesViewModel: ModulePagesViewModel
    
    var body: some View {
        if viewModel.isLoading || modulePagesViewModel.isLoading {
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
                        if let audio = viewModel.audioData {
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
                            Text("Тыңдаңыз және қайталаңыз.")
                                .font(.system(size: 14, weight: .regular))
                            if modulePagesViewModel.acceptLanguage == "en" {
                                Text("Listen and repeat.")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundStyle(Colors.buttonInactive)
                            } else {
                                Text("Прослушайте и повторите.")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundStyle(Colors.buttonInactive)
                            }
                        }
                        
                        Spacer()
                    }
                    
                    VStack {
                        Text(viewModel.data.title)
                            .font(.system(size: 14, weight: .regular))
                        Text(viewModel.data.translation.title)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(Colors.buttonInactive)
                        
                    }
                    .padding(.horizontal, 40)
                    .padding(.vertical, 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                            .foregroundColor(Colors.brandPrimary)
                    )
                    
                    if let image = viewModel.image {
                        image
                            .resizable()
                            .frame(maxHeight: 200)
                            .cornerRadius(12)
                    }
                    
                    Spacer()
                    
                    Button {
                        modulePagesViewModel.getPages()
                    } label: {
                        ButtonView(buttonType: .continue)
                    }
                    
                }
                .blur(radius: viewModel.isLoading || modulePagesViewModel.isLoading ? 3 : 0)
                .padding(24)
            }
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
