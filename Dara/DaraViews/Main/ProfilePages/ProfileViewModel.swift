//
//  ProfileViewModel.swift
//  Dara
//
//  Created by Yessimkhan Zhumash on 08.06.2024.
//

import Foundation
import SwiftfulRouting
import SwiftUI
import PhotosUI

class ProfileViewModel: ObservableObject {
    let router: AnyRouter
    @Published var avatarImage: UIImage?
    @Published var photosPickerItem: PhotosPickerItem?
    @Published var showLogoutAlert: Bool = false
    @Published var language: UserLanguage = .en
    @Published var level: UserLevel = .A2
    @AppStorage("isAuthorized") var isAuthorized: Bool = false
    @AppStorage("accessToken") var accessToken: String?
    @AppStorage("userId") var userId: String?
    @AppStorage("userLevel") var userLevel: Int = 1
    @AppStorage("userEmail") var userEmail: String?
    @AppStorage("userName") var userName: String?
    @AppStorage("userPhone") var userPhone: String?
    @AppStorage("userLanguage") var userLanguage: String = NSLocale.current.language.languageCode?.identifier ?? "en"

    init(router: AnyRouter) {
        self.router = router
        level = switch userLevel {
        case 1 : UserLevel.A1
        case 2 : UserLevel.A2
//        case 3 : UserLevel.B1
//        case 4 : UserLevel.B2
//        case 5 : UserLevel.C1
//        case 6 : UserLevel.C2
        default : UserLevel.A1
        }
        language = switch userLanguage {
        case "en" : UserLanguage.en
        case "ru" : UserLanguage.ru
        default: UserLanguage.en
        }
    }
    
    func changePassword() {
        router.showScreen(.sheet) { router in
            ChangePasswordPage(viewModel: ChangePasswordViewModel(router: router))
        }
    }
    
    func openPersonalInformation() {
        router.showScreen(.sheet) { router in
            PersonalInformationPage(viewModel: PersonalInformationViewModel(router: router))
        }
    }
    
    func logout() {
        isAuthorized = false
        accessToken = nil
        userId = nil
        userLevel = 1
        userEmail = nil
        userName = nil
        userPhone = nil
        userLanguage = NSLocale.current.language.languageCode?.identifier ?? "en"
    }
    
    func updatePersonalInformation() {
        HomeRepository().updateProfile(levelId: userLevel, email: userEmail ?? "", username: userName ?? "", phone: userPhone ?? "", language: userLanguage) { [weak self] result in
            switch result {
            case .success(let profileResponse):
                self?.userLevel = profileResponse.levelID
                self?.userEmail = profileResponse.email
                self?.userName = profileResponse.username
                self?.userPhone = profileResponse.phone
                self?.userLanguage = profileResponse.language
            case .failure(let error):
                print("Update profile failed: \(error.localizedDescription)")
            }
        }
    }
}
