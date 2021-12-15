//
//  FlowTypes.swift
//  PasscodeEntryDemo
//
//  Created by Martin Gagnon on 12/13/21.
//

import Foundation
import Combine

class MyAppSettings : ObservableObject {
    @Published var language = "English"
    @Published var showPasswordView = "NO"
    @Published var currentAlertType = ""

}

class MyEnvironment {
    static let updateChanged = Notification.Name("EnvironmentChangedUpdate")
    static let shared = MyEnvironment()
    private var sinks = [AnyCancellable]()
    var values = [Any]()
    
    private init() {}
    
    func register<T: ObservableObject>(_ value:T) {
        values.append(value)
        let sink = value.objectWillChange.sink {_ in
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: Self.updateChanged, object: value)
            }
        }
        sinks.append(sink)
    }
}

protocol GlobalUpdating {
    func update()
}

extension GlobalUpdating {
    func registerForUpdate() {
        let mirror = Mirror(reflecting: self)
        
        for child in mirror.children {
            if let result = child.value as? AnyGlobal {
                NotificationCenter.default.addObserver(forName: MyEnvironment.updateChanged, object: result.anyWrappedValue, queue: .main) { _ in
                    self.update()
                }
            }
        }
        update()
    }
}

@propertyWrapper struct Global<ObjectType:
    ObservableObject>: AnyGlobal  {
    var wrappedValue: ObjectType
    var anyWrappedValue: Any { wrappedValue }
    
    init() {
        if let value = MyEnvironment.shared.values.first(where: { $0 is ObjectType}) as? ObjectType {
            self.wrappedValue = value
        }
        else {
            fatalError("Missing type in FlowTypes:Global")
        }
    }
}

protocol AnyGlobal {
    var anyWrappedValue: Any { get }
}
