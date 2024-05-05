//
//  Matching.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 09.04.2024.
//

import SwiftUI

struct Matching: View {
    @StateObject var viewModel: MathingViewModel
    @StateObject var modulePagesViewModel: ModulePagesViewModel
    var body: some View {
        ZStack {
            if viewModel.isLoading || modulePagesViewModel.isLoading {
                LoaderView()
            }
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
                
                VStack(alignment: .leading) {
                    Text("Дұрыс жауаппен сәйкестендір.")
                    if modulePagesViewModel.acceptLanguage == "en" {
                        Text("Match with the correct answer.")
                            .font(.callout)
                    } else {
                        Text("Сопоставьте правильный ответ.")
                            .font(.callout)
                    }
                }
                
                HStack (spacing: 20) {
                    VStack (spacing: 20) {
                        MatchCards(text: viewModel.shuffledQuestions[0].title, isSelected: $viewModel.isSelected0, isCorrect: $viewModel.isCorrect0) {
                            viewModel.selectedQ = 0
                            viewModel.isSelected1 = false
                            viewModel.isSelected2 = false
                            viewModel.isCorrectMatch()
                        }
                        MatchCards(text: viewModel.shuffledQuestions[1].title, isSelected: $viewModel.isSelected1, isCorrect: $viewModel.isCorrect1) {
                            viewModel.selectedQ = 1
                            viewModel.isSelected0 = false
                            viewModel.isSelected2 = false
                            viewModel.isCorrectMatch()
                        }
                        MatchCards(text: viewModel.shuffledQuestions[2].title, isSelected: $viewModel.isSelected2, isCorrect: $viewModel.isCorrect2) {
                            viewModel.selectedQ = 2
                            viewModel.isSelected1 = false
                            viewModel.isSelected0 = false
                            viewModel.isCorrectMatch()
                        }
                        
                    }
                    VStack (spacing: 20) {
                        
                        MatchCards(text: viewModel.shuffledAnswers[0].translation.title, isSelected: $viewModel.isSelected10, isCorrect: $viewModel.isCorrect10) {
                            viewModel.selectedA = 0
                            viewModel.isSelected11 = false
                            viewModel.isSelected12 = false
                            viewModel.isCorrectMatch()
                        }
                        MatchCards(text: viewModel.shuffledAnswers[1].translation.title, isSelected: $viewModel.isSelected11, isCorrect: $viewModel.isCorrect11) {
                            viewModel.selectedA = 1
                            viewModel.isSelected10 = false
                            viewModel.isSelected12 = false
                            viewModel.isCorrectMatch()
                        }
                        MatchCards(text: viewModel.shuffledAnswers[2].translation.title, isSelected: $viewModel.isSelected12, isCorrect: $viewModel.isCorrect12) {
                            viewModel.selectedA = 2
                            viewModel.isSelected11 = false
                            viewModel.isSelected10 = false
                            viewModel.isCorrectMatch()
                        }
                        
                    }
                }
                
                Spacer()
                
                Button {
                    modulePagesViewModel.getPages()
                } label: {
                    ButtonView(buttonType: .continue)
                }
                
            }
        }
        .padding(24)
    }
}

struct MatchCards: View {
    let text: String
    @Binding var isSelected: Bool
    @Binding var isCorrect: Bool?
    var onTap: () -> Void
    var body: some View {
        if let isCorrect = isCorrect {
            if isCorrect {
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 160, height: 130)
                        .cornerRadius(12)
                }
            } else {
                ZStack {
                    Rectangle()
                        .foregroundColor(Colors.wrongAnswer)
                        .frame(width: 160, height: 130)
                        .cornerRadius(12)
                    Text(text)
                        .font(.system(size: 18))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Colors.white)
                }
                
            }
        } else if !isSelected {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 160, height: 130)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .inset(by: 0.5)
                            .stroke(Colors.brandPrimary, lineWidth: 2)
                    )
                Text(text)
                    .font(.system(size: 18))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
            }
            .onTapGesture {
                withAnimation(.spring) {
                    isSelected.toggle()
                }
                onTap()
            }
        } else {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 160, height: 130)
                    .cornerRadius(12)
                    .background(Colors.brandPrimary.cornerRadius(12))
                
                Text(text)
                    .font(.system(size: 18))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Colors.white)
            }
            .onTapGesture {
                withAnimation(.spring) {
                    isSelected.toggle()
                }
                onTap()
            }
        }
    }
}
