//
//  ChooseLevelPage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 02.04.2024.
//

import SwiftUI
import SwiftfulRouting

struct ChooseLevelPage: View {
    
    @StateObject var viewModel: ChooseLevelViewModel
    @AppStorage("userLanguage") var userLanguage: String = NSLocale.current.language.languageCode?.identifier ?? "en"

    var body: some View {
        
        VStack {
            Spacer()
            ChooseLevelView(selectedLevel: $viewModel.level)
            Button {
                viewModel.goChooseTimePage()
            } label: {
                ButtonView(buttonType: .next)
            }
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
        .padding(.horizontal, 24)
        .padding(.bottom, 42)
    }
}

public enum UserLevel: String, CaseIterable, Identifiable {
    case A1
    case A2
//    case B1
//    case B2
//    case C1
//    case C2
    public var id: UserLevel { self }
    
    var title: LocalizedStringResource {
        switch self {
        case .A1:
            "A1: Beginner"
        case .A2:
            "A2: Elementary"
//        case .B1:
//            "B1: Intermediate"
//        case .B2:
//            "B2: Upper-Intermediate"
//        case .C1:
//            "C1: Advanced"
//        case .C2:
//            "C2: Proficient"
        }
    }
    var levelValue: Int {
        switch self {
        case .A1: return 1
        case .A2: return 2
//        case .B1: return 3
//        case .B2: return 4
//        case .C1: return 5
//        case .C2: return 6
        }
    }
}

struct ChooseLevelView: View {
    
    @Binding var selectedLevel: UserLevel
    
    
    var body: some View {
        
        VStack (spacing: 20){
            
            Images.eaglesImage
            
            Text("Choose your level")
                .font(.title)
                .fontWeight(.semibold)
            
            Picker("Choose your level", selection: $selectedLevel) {
                ForEach(UserLevel.allCases) { category in
                    Text(category.title).tag(category)
                        .font(.callout)
                }
            }
            .pickerStyle(.wheel)
            
        }
    }
}

#Preview {
    RouterView { router in
        ChooseLevelPage(viewModel: ChooseLevelViewModel(router: router, language: "", userName: "", userNumber: "", userEmail: "", password: ""))
    }
}
