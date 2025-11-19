//
//  Observable.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 17/11/25.
//

class Observable<T> {
    var value: T {
        didSet {
            listener?(value)
        }
    }

    private var listener: ((T) -> Void)?

    init(_ value: T) {
        self.value = value
    }

    func bind(_ listener: @escaping (T) -> Void) {
        self.listener = listener
        listener(value)
    }
}
