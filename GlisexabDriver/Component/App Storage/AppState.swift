//
//  AppState.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 30/10/25.
//

import SwiftUI
internal import Combine

enum AppStorageKey: String {
    case isLoggedIn
    case useriD
    case cardiD
}

final class AppState: ObservableObject {
    @AppStorage(AppStorageKey.isLoggedIn.rawValue) var isLoggedIn: Bool = false
    @AppStorage(AppStorageKey.useriD.rawValue) var useriD: String = ""
    @AppStorage(AppStorageKey.cardiD.rawValue) var cardiD: String = ""
}
