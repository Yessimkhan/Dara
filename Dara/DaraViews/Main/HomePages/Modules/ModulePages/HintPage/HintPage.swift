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
            }
            ScrollView {
                LazyVStack (spacing: 50) {
                    
                    Images.eaglesImage
                    
                    ForEach(viewModel.imagesArray.indices, id: \.self) { index in
                        viewModel.imagesArray[index]
                    }
                    
                    Spacer()
                    
                    Button {
                        modulePagesViewModel.getPages()
                    } label: {
                        ButtonView(buttonType: .continue)
                    }
                }
                .blur(radius: viewModel.isLoading || modulePagesViewModel.isLoading ? 3 : 0)
                .padding(24)
            }
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

