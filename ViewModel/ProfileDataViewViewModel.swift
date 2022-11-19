//
//  ProfileDataViewViewModel.swift
//  Twitter
//
//  Created by Jennifer Chukwuemeka on 08/11/2022.
//

import Foundation
import Combine

final class ProfileDataFormviewViewModel: ObservableObject {
    @Published var displayName: String?
    @Published var username: String?
    @Published var bio: String?
    @Published var avatarPath: String?
}
