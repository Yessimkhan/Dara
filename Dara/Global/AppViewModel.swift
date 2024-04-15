//
//  AppViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 07.04.2024.
//

import Foundation
import Combine

public final class AppViewModel: ObservableObject {
    public static let shared = AppViewModel()
    
    @Published var isLogin: Bool = false
}
