//
//  TaskList.swift
//  Subtasks
//

import Adwaita

struct TaskList: View {

    @Binding var tasks: [Task]
    @Binding var destination: NavigationStack<Binding<Task>>
    @State private var showAddDialog = false
    @State private var addDialogText = ""
    @State private var focusEntry: Signal = .init()
    @State private var showDeleteDialog = false
    @State private var showAboutDialog = false
    var app: GTUIApp
    var deleteTask: (() -> Void)?

    var view: Body {
        ScrollView {
            list
        }
        .topToolbar {
            HeaderBar {
                Button(icon: .default(icon: .listAdd)) {
                    addDialog()
                }
                .keyboardShortcut("n".ctrl(), app: app)
                .tooltip(Loc.addTooltip)
            } end: {
                if deleteTask == nil {
                    Button(icon: .default(icon: .dialogInformation)) {
                        showAboutDialog = true
                    }
                    .tooltip(Loc.about)
                } else {
                    Button(icon: .default(icon: .userTrash)) {
                        showDeleteDialog = true
                    }
                    .tooltip(Loc.deleteTooltip)
                }
            }
        }
        .dialog(visible: $showAddDialog.onSet { _ in cancel() }, id: "add") {
            dialog
        }
        .alertDialog(visible: $showDeleteDialog, heading: Loc.deleteTitle, body: Loc.deleteDescription, id: "delete")
        .response(Loc.cancel, role: .close) { }
        .response(Loc.delete, appearance: .destructive, role: .default) {
            deleteTask?()
        }
        .aboutDialog(
            visible: $showAboutDialog,
            app: "Subtasks",
            developer: "david-swift",
            version: "0.1.0",
            icon: .custom(name: "io.github.david_swift.Subtasks"),
            website: .init(string: "https://github.com/david-swift/Subtasks"),
            issues: .init(string: "https://github.com/david-swift/Subtasks/issues")
        )
    }

    var list: View {
        VStack {
            if tasks.isEmpty {
                StatusPage()
                    .title(Loc.noTasks)
                    .description(Loc.createNewTask)
                    .iconName(Icon.default(icon: .checkboxChecked).string)
                    .child {
                        Button(Loc.addTooltip) {
                            addDialog()
                        }
                        .style("suggested-action")
                        .style("pill")
                        .halign(.center)
                    }
                    .valign(.center)
                    .vexpand()
            } else {
                List(tasks, selection: nil) { task in
                    taskRow(task: $tasks[id: task.id, default: .init(label: "")])
                }
                .valign(.start)
                .padding(20)
                .style("boxed-list")
                .frame(maxWidth: 500)
            }
        }
    }

    var dialog: View {
        Form {
            EntryRow(Loc.label, text: $addDialogText)
                .entryActivated {
                    add()
                }
                .frame(minWidth: 250)
                .focus(focusEntry)
        }
        .padding(20)
        .valign(.start)
        .topToolbar {
            HeaderBar {
                Button(Loc.cancel) {
                    cancel()
                }
            } end: {
                Button(Loc.add) {
                    add()
                }
                .style("suggested-action")
            }
            .showEndTitleButtons(false)
        }
    }

    func taskRow(task: Binding<Task>) -> View {
        ActionRow()
            .title(task.wrappedValue.label)
            .subtitle(Loc.subtasks(count: task.wrappedValue.subtasks.count))
            .prefix {
                CheckButton()
                    .active(task.done)
                    .inconsistent(task.wrappedValue.mixed)
                    .style("selection-mode")
                    .valign(.center)
            }
            .suffix {
                ButtonContent()
                    .iconName(Icon.default(icon: .goNext).string)
            }
            .activatableWidget {
                Button()
                    .activate {
                        destination.push(task)
                    }
            }
    }

    func addDialog() {
        showAddDialog = true
        focusEntry.signal()
    }

    func cancel() {
        showAddDialog = false
        addDialogText = ""
    }

    func add() {
        tasks.append(.init(label: addDialogText))
        cancel()
    }

}
