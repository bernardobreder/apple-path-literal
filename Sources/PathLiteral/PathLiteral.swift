//
//  PathLiteral.swift
//  PathLiteral
//
//  Created by Bernardo Breder on 20/01/17.
//
//

import Foundation
import Literal
import Path

open class PathLiteral {
    
    var chucks: [[PathLiteralEntry]] = []
    
    static let letters = CharacterSet.letters
    
    static let decimalDigits = CharacterSet.decimalDigits
    
    public init() {}
    
    public convenience init?(string: String) {
        self.init()
        guard string.characters[string.startIndex] == "[" else { return nil }
        guard string.characters[string.index(before: string.endIndex)] == "]" else { return nil }
        let content = string.substring(with: string.index(after: string.startIndex) ..< string.index(before: string.endIndex))
        for item: String in content.characters.split(separator: ",").map({String($0)}) {
            guard let entry = PathLiteralEntrySimple(string: item) else { return nil }
            let paths = Path(entry.path).paths
            self[paths] = entry.value
        }
    }
    
    open subscript(_ array: [String]) -> Literal? {
        get {
            guard let _ = array.last else { return nil }
            let paths = array, cindex = paths.count - 1
            guard cindex < chucks.count else { return nil }
            guard let path = Path(paths) else { return nil }; let hash = path.hashValue
            return chucks[cindex].lazy.filter({$0.hash == hash && $0.path == path}).first?.value
        } set {
            guard let last = array.last else { return }
            let paths = array, cindex = paths.count - 1
            for item in paths { for c in item.unicodeScalars { guard PathLiteral.letters.contains(c) || PathLiteral.decimalDigits.contains(c) else { return } } }
            while cindex >= chucks.count { chucks.append([]) }
            guard let path = Path(paths) else { return }; let hash = path.hashValue
            if let eindex = chucks[cindex].index(where: { entry in entry.hash == hash && entry.path == path }) {
                if let hasNewValue = newValue { chucks[cindex][eindex].value = hasNewValue }
                else { chucks[cindex].remove(at: eindex) }
            } else if let hasNewValue = newValue {
                chucks[cindex].append(PathLiteralEntry(path: path, last: last, lastInt: Int(last) != nil, hash: hash, value: hasNewValue))
            }
        }
    }
    
    public func list(_ parents: String...) -> [String] {
        return chuck(parents).map{$0.path.name}
    }
    
    public func strings(_ parents: String...) -> [String] {
        return array(parents, filter: { $0.value.isString }, map: { $0.value.string! })
    }
    
    public func ints(_ parents: String...) -> [Int] {
        return array(parents, filter: { $0.value.isInt }, map: { $0.value.int! })
    }
    
    public func doubles(_ parents: String...) -> [Double] {
        return array(parents, filter: { $0.value.isDouble }, map: { $0.value.double! })
    }
    
    public func bools(_ parents: String...) -> [Bool] {
        return array(parents, filter: { $0.value.isBool }, map: { $0.value.bool! })
    }
    
    public func entrys() -> [PathLiteralEntrySimple] {
        return chucks.flatMap { chuck in chuck.flatMap { item in PathLiteralEntrySimple(path: item.path.path, value: item.value) } }
    }
    
    public func encode() -> String {
        return "[" + entrys().reduce("", { (a: String, b: PathLiteralEntrySimple) in (a.isEmpty ? "" : a + ", " ) + b.encode()}) + "]"
    }
    
}

extension PathLiteral {
    
    func chuck(_ parents: [String]) -> LazyFilterCollection<[PathLiteralEntry]> {
        guard parents.count < chucks.count else { return [].lazy.filter({ _ in false}) }
        let parent = "/" + parents.joined(separator: "/")
        return chucks[parents.count].lazy.filter({ entry in ("/" + (entry.path.parent ?? "")).hasPrefix(parent) })
    }
    
    func array<T>(_ parents: [String], filter: @escaping (PathLiteralEntry) -> Bool, map: @escaping (PathLiteralEntry) -> T) -> [T] {
        return chuck(parents).filter{ entry in entry.lastInt }.filter(filter).map(map)
    }
    
}

extension PathLiteral: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        var aux = ""
        for chuck in chucks {
            for item in chuck {
                aux += "\"\(item.path)\": \(item.value)\n"
            }
        }
        return aux.trimmingCharacters(in: .newlines)
    }
    
    public var debugDescription: String {
        return description
    }
    
}

public struct PathLiteralEntry {
    
    public let path: Path
    
    public let last: String
    
    public let lastInt: Bool
    
    public let hash: Int
    
    public var value: Literal
    
}

public struct PathLiteralEntrySimple {
    
    let path: String
    
    let value: Literal
    
    public init(path: String, value: Literal) {
        self.path = path
        self.value = value
    }
    
    public init?(string: String) {
        guard let index = string.characters.index(of: ":") else { return nil }
        let path = string.substring(to: index)
        guard let value = try? Literal(encoded: string.substring(from: string.index(after: index))) else { return nil }
        self.init(path: path, value: value)
    }
    
    public func encode() -> String {
        return path + ":" + value.encode()
    }
    
}
