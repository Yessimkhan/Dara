//
//  HintPage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 09.04.2024.
//

import SwiftUI
import SwiftfulRouting

struct HintPage: View {
    @StateObject var viewModel: HintViewModel
    @StateObject var modulePagesViewModel: ModulePagesViewModel
    
    var body: some View {
        ZStack {
            if viewModel.isLoading || modulePagesViewModel.isLoading {
                LoaderView()
            } else {
                ScrollView(showsIndicators: false) {
                    LazyVStack (spacing: 50) {
                        Images.eaglesImage
                        
                        ForEach(viewModel.imagesArray.indices, id: \.self) { index in
                            viewModel.imagesArray[index]
                                .resizable()
                                .scaledToFit()
                        }
                        
                        Spacer()
                    }
                    .blur(radius: viewModel.isLoading || modulePagesViewModel.isLoading ? 3 : 0)
                }
                .padding(.bottom, 10)
                
                VStack {
                    Spacer()
                    Button {
                        modulePagesViewModel.getPages()
                    } label: {
                        if modulePagesViewModel.currentPage > modulePagesViewModel.allPages {
                            ButtonView(buttonType: .finish)
                        } else {
                            ButtonView(buttonType: .continueButton)
                        }
                    }
                }
            }
        }
        .padding(.bottom, 24)
        .padding(.horizontal, 24)
        .toolbar {
            ToolbarItem (placement: .topBarLeading) {
                Button {
                    print("back button tapped \(modulePagesViewModel.currentPage)")
                    modulePagesViewModel.currentPage -= 1
                    viewModel.router.dismissScreen()
                } label: {
                    Image(systemName: "chevron.left")
                        .fontWeight(.semibold)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.router.dismissScreenStack()
                } label: {
                    Image(systemName: "xmark")
                        .fontWeight(.semibold)
                }
            }
        }
    }
}

