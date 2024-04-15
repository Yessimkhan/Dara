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
    
    var body: some View {
        
        VStack {
            Spacer()
            ChooseLevelView()
            Button {
                viewModel.goChooseTimePage()
            } label: {
                ButtonView(buttonType: .next)
            }
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 42)
    }
}

struct ChooseLevelView: View {
    
    enum LanguageLevel: String, CaseIterable, Identifiable {
        case A1 = "A1 - Beginner"
        case A2 = "A2 - Elementary"
        case B1 = "B1 - Intermediate"
        case B2 = "B2 - Upper-Intermediate"
        case C1 = "C1 - Advanced"
        case C2 = "C2 - Proficency"
        var id: LanguageLevel { self }
    }
    
    
    @State private var selectedLevel: LanguageLevel = .A1
    
    
    var body: some View {
        
        VStack (spacing: 20){
            
            Images.eaglesImage
            
            Text("Choose your level")
                .font(.title)
                .fontWeight(.semibold)
            
            Picker("Choose your level", selection: $selectedLevel) {
                ForEach(LanguageLevel.allCases) { category in
                    Text(category.rawValue).tag(category)
                        .font(.callout)
                }
            }
            .pickerStyle(.wheel)
            
        }
    }
}

#Preview {
    RouterView { router in
        ChooseLevelPage(viewModel: ChooseLevelViewModel(router: router))
    }
}
