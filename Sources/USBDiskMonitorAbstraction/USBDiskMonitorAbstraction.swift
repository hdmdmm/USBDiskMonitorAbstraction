// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import Combine
import CommonAbstraction

public protocol USBDiskMonitorProtocol: ObservableServiceProtocol {
    var mountedDisk: PassthroughSubject<[USBDisk], DiskMountError> { get }
}

public enum DiskMountError: Error {
    case diskNotFound, diskAlreadyMounted, diskNotMounted, diskNotUnmounted, diskNotRemovable, diskNotWritable, diskNotReadable
}

public struct USBDisk: Identifiable {
    public let id: UUID
    public let mediaName: String
    public var name: String
    public var volume: String?
    public let size: Int64?
    public var isMounted: Bool
    
    public init(id: UUID, name: String, volume: String?, isMounted: Bool, size: Int64?, mediaName: String) {
        self.id = id
        self.name = name
        self.volume = volume
        self.isMounted = isMounted
        self.size = size
        self.mediaName = mediaName
    }
}

extension USBDisk: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: USBDisk, rhs: USBDisk) -> Bool {
        lhs.id == rhs.id
    }
}
