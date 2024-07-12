//
//  Matching.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 09.04.2024.
//

import SwiftUI

struct Matching: View {
    @StateObject var viewModel: MatchingViewModel
    @StateObject var modulePagesViewModel: ModulePagesViewModel
    var body: some View {
        VStack {
            if viewModel.isLoading || modulePagesViewModel.isLoading {
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
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(viewModel.getQuestion())
                                .font(.system(size: 14, weight: .regular))
                            
                            Text(viewModel.getQuestionTranslation())
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(Colors.buttonInactive)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    HStack (spacing: 20) {
                        VStack (spacing: 20) {
                            if viewModel.shuffledQuestions.count >= 1 {
                                MatchCards(text: viewModel.shuffledQuestions[0], isSelected: $viewModel.isSelected0, isCorrect: $viewModel.isCorrect0) {
                                    viewModel.selectedQ = 0
                                    viewModel.isSelected1 = false
                                    viewModel.isSelected2 = false
                                    viewModel.isCorrectMatch()
                                }
                            }
                            if viewModel.shuffledQuestions.count >= 2 {
                                MatchCards(text: viewModel.shuffledQuestions[1], isSelected: $viewModel.isSelected1, isCorrect: $viewModel.isCorrect1) {
                                    viewModel.selectedQ = 1
                                    viewModel.isSelected0 = false
                                    viewModel.isSelected2 = false
                                    viewModel.isCorrectMatch()
                                }
                            }
                            if viewModel.shuffledQuestions.count >= 3 {
                                MatchCards(text: viewModel.shuffledQuestions[2], isSelected: $viewModel.isSelected2, isCorrect: $viewModel.isCorrect2) {
                                    viewModel.selectedQ = 2
                                    viewModel.isSelected1 = false
                                    viewModel.isSelected0 = false
                                    viewModel.isCorrectMatch()
                                }
                            }
                        }
                        VStack (spacing: 20) {
                            if viewModel.shuffledAnswers.count >= 1 {
                                MatchCards(text: viewModel.shuffledAnswers[0], isSelected: $viewModel.isSelected10, isCorrect: $viewModel.isCorrect10) {
                                    viewModel.selectedA = 0
                                    viewModel.isSelected11 = false
                                    viewModel.isSelected12 = false
                                    viewModel.isCorrectMatch()
                                }
                            }
                            if viewModel.shuffledAnswers.count >= 2 {
                                MatchCards(text: viewModel.shuffledAnswers[1], isSelected: $viewModel.isSelected11, isCorrect: $viewModel.isCorrect11) {
                                    viewModel.selectedA = 1
                                    viewModel.isSelected10 = false
                                    viewModel.isSelected12 = false
                                    viewModel.isCorrectMatch()
                                }
                            }
                            if viewModel.shuffledAnswers.count >= 3 {
                                MatchCards(text: viewModel.shuffledAnswers[2], isSelected: $viewModel.isSelected12, isCorrect: $viewModel.isCorrect12) {
                                    viewModel.selectedA = 2
                                    viewModel.isSelected11 = false
                                    viewModel.isSelected10 = false
                                    viewModel.isCorrectMatch()
                                }
                            }
                        }
                    }
                    .frame(maxHeight: .infinity)
                    
                    Button {
                        modulePagesViewModel.score += 1
                        modulePagesViewModel.getPages()
                    } label: {
                        if modulePagesViewModel.currentPage > modulePagesViewModel.allPages {
                            ButtonView(buttonType: .finish, disabled: $viewModel.isDisabled)
                        } else {
                            ButtonView(buttonType: .continueButton, disabled: $viewModel.isDisabled)
                        }
                    }.disabled(viewModel.isDisabled)
                    
                }
            }
        }
        .toolbar {
            if modulePagesViewModel.moduleId != 4 {
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
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    modulePagesViewModel.router.dismissScreenStack()
                } label: {
                    Image(systemName: "xmark")
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
                        .frame(width: 160, height: 130)
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
                    .frame(width: 160, height: 130)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Colors.black)
            }
            .background(Colors.white)
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
                    .frame(width: 160, height: 130)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Colors.white)
            }
            .background(.clear)
            .onTapGesture {
                withAnimation(.spring) {
                    isSelected.toggle()
                }
                onTap()
            }
        }
    }
}
