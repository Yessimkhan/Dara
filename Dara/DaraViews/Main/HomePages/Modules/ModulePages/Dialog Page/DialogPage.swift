//
//  DialogPage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 09.05.2024.
//

import SwiftUI

struct DialogPage: View {
    @StateObject var viewModel: DialogViewModel
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
                    ScrollView(showsIndicators: false) {
                        VStack (alignment: .leading) {
                            ForEach(viewModel.data.indices, id: \.self) { index in
                                if let data = viewModel.audioData[index] {
                                    HStack(alignment: .top, spacing: 16) {
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
                                                SoundManager.instance.playAudio(audioData: data)
                                            }
                                        
                                        VStack(alignment: .leading) {
                                            Text(viewModel.data[index].title.replacingOccurrences(of: "\\n", with: "\n"))
                                                .font(.system(size: 14, weight: .regular))
                                            Text(viewModel.data[index].translation.title.replacingOccurrences(of: "\\n", with: "\n"))
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
                                    }
                                    Spacer()
                                }
                            }
                        }
                        .padding()
                    }
                    
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
                .blur(radius: modulePagesViewModel.isLoading ? 3 : 0)
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
