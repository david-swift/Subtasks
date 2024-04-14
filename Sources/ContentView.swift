//
//  ContentView.swift
//  Subtasks
//

import Adwaita

struct ContentView: WindowView {

    @State("tasks")
    private var tasks: [Task] = []
    @State private var destination: NavigationStack<Binding<Task>> = .init()
    @State("width")
    private var width = 500
    @State("height")
    private var height = 450
    @State("maximized")
    private var maximized = false
    var app: GTUIApp

    var view: Body {
        NavigationView($destination, "Subtasks") { task in
            TaskList(tasks: task.subtasks, destination: $destination, app: app) {
                tasks.delete(id: task.wrappedValue.id)
                destination.pop()
            }
        } initialView: {
            TaskList(tasks: $tasks, destination: $destination, app: app)
        }
        .frame(minWidth: 250, minHeight: 200)
    }

    func window(_ window: Window) -> Window {
        window
            .size(width: $width, height: $height)
            .maximized($maximized)
    }

}
