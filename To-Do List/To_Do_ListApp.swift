//
//  To_Do_ListApp.swift
//  To-Do List
//
//  Created by Leon Gell on 2023-04-03.
//
import Blackbird
import SwiftUI

@main
struct To_Do_ListApp: App {
    var body: some Scene {
        WindowGroup {
            ListView()
            // make the database available to all other views through the enviornment
                .environment(\.blackbirdDatabase, AppDatabase.instance)
        }
    }
}
