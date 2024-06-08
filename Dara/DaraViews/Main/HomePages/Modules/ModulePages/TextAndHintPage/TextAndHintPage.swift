//
//  TextAndHintPage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 08.06.2024.
//

import SwiftUI
import SwiftfulRouting

struct TextAndHintPage: View {
    @StateObject var viewModel: TextAndHintViewModel
    @StateObject var modulePagesViewModel: ModulePagesViewModel
    
    var body: some View {
        ZStack {
            if modulePagesViewModel.isLoading {
                LoaderView()
            } else {
                VStack {
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
                        VStack (spacing: 32) {
                            HStack(spacing: 16) {
                                if viewModel.data[viewModel.textIndex].audio != "" {
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
                            
                            if viewModel.data[viewModel.textIndex].title != "" {
                                VStack (alignment: .center){
                                    Text(viewModel.data[viewModel.textIndex].title.replacingOccurrences(of: "\\n", with: "\n"))
                                        .font(.system(size: viewModel.image == nil ? 20 : 14 , weight: .semibold))
                                        .multilineTextAlignment(.center)
                                    Text(viewModel.data[viewModel.textIndex].translation.title.replacingOccurrences(of: "\\n", with: "\n"))
                                        .font(.system(size: viewModel.image == nil ? 20 : 14, weight: .semibold))
                                        .foregroundStyle(Colors.buttonInactive)
                                        .multilineTextAlignment(.center)
                                }
                                .padding(.horizontal, 40)
                                .padding(.vertical, 10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(lineWidth: 1)
                                        .foregroundColor(Colors.brandPrimary)
                                )
                            }
                            
                            if viewModel.isLoadingImage {
                                LoaderView()
                            } else if let image = viewModel.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 200)
                                    .cornerRadius(12)
                            }
                            if viewModel.isLoading {
                                LoaderView()
                            } else {
                                LazyVStack (spacing: 50) {
                                    ForEach(viewModel.imagesArray.indices, id: \.self) { index in
                                        viewModel.imagesArray[index]
                                    }
                                }
                            }
                        }
                        Spacer(minLength: 0)
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

//#Preview {
//    TextAndHintPage()
//}
