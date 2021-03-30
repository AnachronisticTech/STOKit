import Foundation

public protocol Character: Codable {
    var identifier: UUID { get }

    var name: String { get }
    var faction: Faction { get }
    var career: Career { get }

    init(name: String, faction: Faction, career: Career)

    func save()

    // static func load(_ name: String) -> Character?
}
