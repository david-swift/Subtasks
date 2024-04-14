//
//  Subtasks.swift
//  Subtasks
//

import Adwaita
import CAdw

@main
struct Subtasks: App {

    let id = "io.github.david_swift.Subtasks"
    var app: GTUIApp!

    var scene: Scene {
        Window(id: "main") { _ in
            ContentView(app: app)
        }
        .closeShortcut()
        .quitShortcut()
    }

}
