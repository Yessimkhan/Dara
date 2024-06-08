//
//  ShuffledialogPage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 07.06.2024.
//

import SwiftUI
import SwiftfulRouting
import WrappingStack

struct ShuffledialogPage: View {
    @StateObject var viewModel: ShuffledialogViewModel
    @StateObject var modulePagesViewModel: ModulePagesViewModel
    @Environment(\.editMode) private var editMode
    
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
                            Text(viewModel.getQuestion())
                                .font(.system(size: 14, weight: .regular))
                            
                            Text(viewModel.getQuestionTranslation())
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(Colors.buttonInactive)
                        }
                        
                        Spacer()
                    }
                    
                    List {
                        ForEach(viewModel.shuffledVariants, id: \.self) { element in
                            TextView(text: element)
                                .disabled(viewModel.variantsDisabled)
                        }
                        .onMove(perform: viewModel.moveItem)
                    }
                    .listStyle(.plain)
                    .environment(\.editMode, $viewModel.editMode)
                    
                    Spacer(minLength: 0)
                    
                    
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

//#Preview {
//    RouterView { router in
//        ShuffledialogPage(viewModel: ShuffledialogViewModel(router: router, data: Content(
//            id: "66605661e8aad763a4eb72c5",
//            topicId: 3,
//            moduleId: 3,
//            pageId: 3,
//            title: "Сәлем Аида.",
//            description: nil,
//            logo: nil,
//            content: nil,
//            example: "",
//            image: "",
//            audio: "",
//            variants: [
//                "Сәлем Аида.",
//                "Сәлем.",
//                "Қалайсың?",
//                "Рақмет, жақсымын.",
//                "Өзің қалайсың?",
//                "Мен де жақсымын.",
//                "Көріскенше",
//                "Сау бол!"
//            ],
//            question: "Диологты аяқтаңыз",
//            translation: Translation(
//                title: "Сәлем Аида.",
//                description: nil,
//                example: "",
//                question: "Complete the dialogue"))),
//                        modulePagesViewModel:
//                            ModulePagesViewModel(
//                                router: router,
//                                lessonId: 1,
//                                moduleId: 1,
//                                allPages: 1,
//                                allTasks: 1,
//                                currentPage: 1,
//                                currentTask: 2))
//    }
//}
