import Foundation

public protocol STOCharacter: Codable {
    var identifier: UUID { get }

    var name: String { get }
    var faction: STOFaction { get }
    var career: STOCareer { get }

    init(name: String, faction: STOFaction, career: STOCareer)

    func save()

    // static func load(_ name: String) -> STOCharacter?
}
