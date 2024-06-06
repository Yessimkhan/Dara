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
                        
                        HStack() {
                            VStack(alignment: .leading) {
                                Text("Тыңдаңыз және қайталаңыз.")
                                    .font(.system(size: 14, weight: .regular))
                                if modulePagesViewModel.userLanguage == "en" ||  modulePagesViewModel.userLanguage == "us"{
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
                    }
                    ScrollView(showsIndicators: false) {
                        VStack {
                            ForEach(viewModel.data.indices, id: \.self) { index in
                                VStack(alignment: .leading) {
                                    VStack(alignment: .leading) {
                                        Text(viewModel.data[index].title.replacingOccurrences(of: "\\n", with: "\n"))
                                            .font(.system(size: 14, weight: .regular))
                                        Text(viewModel.data[index].translation.title.replacingOccurrences(of: "\\n", with: "\n"))
                                            .font(.system(size: 14, weight: .regular))
                                            .foregroundStyle(Colors.buttonInactive)
                                    }
                                    
                                    AudioPlayerView(data: $viewModel.audioData[index], isPlaying: $viewModel.isPlaying[index])
                                }
                                .padding()
                                .background(.ultraThinMaterial)
                                .cornerRadius(16)
                                Spacer()
                            }
                        }
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
