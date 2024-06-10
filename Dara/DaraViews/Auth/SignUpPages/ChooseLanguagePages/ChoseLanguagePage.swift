//
//  ChoseLanguagePage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 27.02.2024.
//

import SwiftUI
import SwiftfulRouting

public enum UserLanguage: String, CaseIterable, Identifiable {
    case en
    case ru
    
    public var id: UserLanguage { self }
    
    var title: String {
        switch self {
        case .en : "Eng"
        case .ru : "Rus"
        }
    }
}

struct ChoseLanguagePage: View {
    
    @StateObject var viewModel: ChooseLanguageViewModel
    @AppStorage("userLanguage") var userLanguage: String = NSLocale.current.language.languageCode?.identifier ?? "en"

    var body: some View {
        ZStack {
            VStack (spacing: 40) {
                Images.eaglesImage
                
                HStack (spacing: 20){
                    Button {
                        userLanguage = "en"
                        viewModel.language = "en"
                        viewModel.goCreateAccountPage()
                    } label: {
                        ButtonView(buttonType: .english)
                    }
                    
                    Button {
                        userLanguage = "ru"
                        viewModel.language = "ru"
                        viewModel.goCreateAccountPage()
                    } label: {
                        ButtonView(buttonType: .russian)
                    }
                }
            }
            .padding(.horizontal, 24)
        }
        .toolbar {
            ToolbarItem (placement: .topBarLeading) {
                Button {
                    viewModel.router.dismissScreen()
                } label: {
                    Image(systemName: "chevron.left")
                        .fontWeight(.semibold)
                }
            }
        }
        .environment(\.locale, Locale(identifier: userLanguage))
    }
}

#Preview {
    RouterView { router in
        ChoseLanguagePage(viewModel: ChooseLanguageViewModel(router: router))
    }
    
}
