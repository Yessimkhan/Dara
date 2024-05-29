//
//  ChooseTimePage.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 10.03.2024.
//

import SwiftUI
import SwiftfulRouting

struct ChooseTimePage: View {
    
    @StateObject var viewModel: ChooseTimeViewModel
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                LoaderView()
            }
            VStack {
                Spacer()
                ChooseTimeView(selectedTime: $viewModel.time)
                Button {
                    viewModel.goMenuTabBar()
                } label: {
                    ButtonView(buttonType: .next)
                }
            }
        }
        .blur(radius: viewModel.isLoading ? 3 : 0)
        .padding(.horizontal, 24)
        .padding(.bottom, 42)
    }
}

#Preview {
    RouterView { router in
        ChooseTimePage(viewModel: ChooseTimeViewModel(router: router, language: "", userName: "", userNumber: "", userEmail: "", password: "", level: .A1))
    }
}

struct ChooseTimeView: View {
    
    @State private var hour: Int = 0
    @State private var minute: Int = 0
    
    enum TimeLevel: Int, CaseIterable, Identifiable {
        case five = 5
        case ten = 10
        case fifteen = 15
        case twenty = 20
        case twentyFive = 25
        case thirty = 30
        
        var id: TimeLevel { self }
        
        var stringValue: String {
            return "\(self.rawValue) - minutes"
        }
    }
    
    @Binding var selectedTime: TimeLevel
    
    var body: some View {
        VStack (spacing: 20){
            
            Images.eaglesImage
            
            Text("What’s your daily study goal in minutes?")
                .font(.title)
                .fontWeight(.semibold)
            
            Picker("", selection: $selectedTime) {
                ForEach(TimeLevel.allCases) { category in
                    Text(category.stringValue).tag(category)
                }
            }
            .pickerStyle(.wheel)
            
        }
    }
}

