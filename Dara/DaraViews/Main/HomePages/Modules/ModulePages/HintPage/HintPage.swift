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
                ScrollView(showsIndicators: false) {
                    LazyVStack (spacing: 50) {
                        Images.eaglesImage
                        
                        ForEach(viewModel.imagesArray.indices, id: \.self) { index in
                            viewModel.imagesArray[index]
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
                        ButtonView(buttonType: .continue)
                    }
                }
            }
            .padding(24)
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

