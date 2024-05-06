//
//  TrueFalsePage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 18.04.2024.
//

import SwiftUI

struct TrueFalsePage: View {
    @StateObject var viewModel: TrueFalseViewModel
    @StateObject var modulePagesViewModel: ModulePagesViewModel
    @State var trueFalseButtonIsActive: Bool = true
    
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
                    }
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Дұрыс немесе бұрыс екенін тап.")
                            if modulePagesViewModel.acceptLanguage == "en" {
                                Text("Guess what is right or wrong.")
                                    .font(.callout)
                            } else {
                                Text("Угадайте, что правильно или неправильно.")
                                    .font(.callout)
                            }
                        }
                        
                        Spacer()
                    }
                    
                    if let image = viewModel.image {
                        image
                            .resizable()
                            .frame(maxHeight: 300)
                            .cornerRadius(12)
                    }
                    
                    VStack {
                        Text(viewModel.data.title)
                            .font(.system(size: 14, weight: .regular))
                        Text(viewModel.data.translation.title)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(Colors.buttonInactive)
                    }
                    
                    Spacer()
                    
                    if trueFalseButtonIsActive {
                        HStack (spacing: 20) {
                            ForEach(viewModel.shuffledVariants, id: \.self) { variant in
                                Button {
                                    let isCorrect = viewModel.isCorrectAnswer(variant)
                                    if isCorrect {
                                        SoundManager.instance.playSound(sound: .success)
                                        viewModel.router.showModal(transition: .move(edge: .bottom), animation: .easeInOut, alignment: .bottom) {
                                            CorrectView(router: viewModel.router, modulePagesViewModel: modulePagesViewModel)
                                        }
                                    } else {
                                        SoundManager.instance.playSound(sound: .sad)
                                        viewModel.router.showModal(transition: .move(edge: .bottom), animation: .easeInOut, alignment: .bottom) {
                                            WrongView(router: viewModel.router, modulePagesViewModel: modulePagesViewModel)
                                        }
                                    }
                                    trueFalseButtonIsActive = false
                                } label: {
                                    ButtonView(buttonType: .custom, buttonText: variant)
                                }
                            }
                        }
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
