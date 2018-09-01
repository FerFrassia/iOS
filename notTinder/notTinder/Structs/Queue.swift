//
//  Queue.swift
//  notTinder
//
//  Created by Fernando N. Frassia on 8/30/18.
//  Copyright © 2018 Fernando N. Frassia. All rights reserved.
//
class Node<T> {
    let data: T
    var next: Node<T>?
    init(_ withData: T) {
        data = withData
    }
}

class List<T> {
    private var head: Node<T>?
    private var tail: Node<T>?
    private var count: Int
    
    init() {
        head = nil
        tail = nil
        count = 0
    }
    
    func getInitialElement() -> T? {
        return head?.data
    }
    
    func appendRight(_ val: T) {
        let newNode = Node(val)
        tail?.next = newNode
        tail = newNode
        if head == nil {
            head = newNode
        }
        count += 1
    }
    
    func deppendLeft() {
        head = head?.next
        count -= 1
    }
    
    func amount() -> Int {
        return count
    }
}

class Queue<T> {
    private var list: List<T>
    
    init() {
        list = List()
    }
    
    func enqueue(_ val: T) {
        list.appendRight(val)
    }
    
    func deque() {
        list.deppendLeft()
    }
    
    func peekNext() -> T? {
        return list.getInitialElement()
    }
    
    func amount() -> Int {
        return list.amount()
    }
    
    
}
