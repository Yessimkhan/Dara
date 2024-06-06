//
//  ShufflewordPage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 06.06.2024.
//

import SwiftUI
import SwiftfulRouting
import WrappingStack

struct ShufflewordPage: View {
    @StateObject var viewModel: ShufflewordViewModel
    @StateObject var modulePagesViewModel: ModulePagesViewModel
    
    let variants:[String] = ["Сәлеметсіз бе",
                             "Келіңіз, отырыңыз.",
                             "Әрине, айта беріңіз",
                             "Рақмет. Мен журналистпін. 7 арнада жұмыс істеймін.",
                             "Сізге сұрағым бар.",
                             "Сәлеметсіз бе!"
    ]
    
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
                            Text(viewModel.data.question ?? "Дұрыс нұсқаны тап.")
                                .font(.system(size: 14, weight: .regular))
                            if modulePagesViewModel.userLanguage == "en" ||  modulePagesViewModel.userLanguage == "us"{
                                Text(viewModel.data.translation.question ?? "Find the correct option.")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundStyle(Colors.buttonInactive)
                            } else {
                                Text(viewModel.data.translation.question ?? "Найдите правильный вариант.")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundStyle(Colors.buttonInactive)
                            }
                        }
                        
                        Spacer()
                    }
                    
                    VStack {
                        Images.eaglesImage
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                        HStack (alignment: .top){
                            WrappingHStack(id: \.self, alignment: .leading, horizontalSpacing: 8, verticalSpacing: 8) {
                                ForEach(viewModel.answerArray, id: \.self) { element in
                                    TextView(text: element)
                                        .onTapGesture {
                                            if let index = viewModel.answerArray.firstIndex(of: element) {
                                                viewModel.answerArray.remove(at: index)
                                            }
                                            viewModel.shuffledVariants.append(element)
                                        }
                                        .disabled(viewModel.variantsDisabled)
                                }
                            }
                            
                        }
                    }
                    Spacer()
                    
                    WrappingHStack(id: \.self, alignment: .leading, horizontalSpacing: 8, verticalSpacing: 8) {
                        ForEach(viewModel.shuffledVariants, id: \.self) { element in
                            TextView(text: element)
                                .onTapGesture {
                                    if let index = viewModel.shuffledVariants.firstIndex(of: element) {
                                        viewModel.shuffledVariants.remove(at: index)
                                    }
                                    viewModel.answerArray.append(element)
                                }
                                .disabled(viewModel.variantsDisabled)
                        }
                    }
                    
                    Button {
                        viewModel.variantsDisabled = true
                        let isCorrect = viewModel.isCorrectAnswer()
                        if isCorrect {
                            SoundManager.instance.playSound(sound: .success)
                            modulePagesViewModel.score += 1
                            viewModel.router.showModal(transition: .move(edge: .bottom), animation: .easeInOut, alignment: .bottom) {
                                CorrectView(router: viewModel.router, modulePagesViewModel: modulePagesViewModel)
                            }
                        } else {
                            SoundManager.instance.playSound(sound: .sad)
                            viewModel.router.showModal(transition: .move(edge: .bottom), animation: .easeInOut, alignment: .bottom) {
                                WrongView(router: viewModel.router, isTest: modulePagesViewModel.moduleId == 4, isDisabled: $viewModel.variantsDisabled, modulePagesViewModel: modulePagesViewModel)
                            }
                        }
                    } label: {
                        ButtonView(buttonType: .check, disabled: $viewModel.variantsDisabled)
                    }.disabled(viewModel.variantsDisabled)
                }
                .padding(24)
                .blur(radius: modulePagesViewModel.isLoading ? 3 : 0)
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
    }
}

struct TextView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .fixedSize(horizontal: false, vertical: true)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Colors.brandPrimary, lineWidth: 1)
            )
    }
}

#Preview {
    RouterView { router in
        ShufflewordPage(viewModel: ShufflewordViewModel(router: router, data: Content(
            id: "66605661e8aad763a4eb72c5",
            topicId: 3,
            moduleId: 3,
            pageId: 4,
            title: "Рақмет, жақсы. Өзіңіз қалайсыз?",
            description: nil,
            logo: nil,
            content: nil,
            example: "",
            image: "",
            audio: "",
            variants: [
                "Рақмет,",
                "жақсы.",
                "Өзіңіз",
                "қалайсыз?"
            ],
            question: "Сөздерді дұрыс орналастырыңыз",
            translation: Translation(
                title: "Thank you, good. How do you feel?",
                description: nil,
                example: "",
                question: "Place the words correctly"))),
                        modulePagesViewModel:
                            ModulePagesViewModel(
                                router: router,
                                lessonId: 1,
                                moduleId: 1,
                                allPages: 1,
                                allTasks: 1,
                                currentPage: 1,
                                currentTask: 2))
    }
}



