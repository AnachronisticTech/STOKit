import Foundation

public class Episode: Codable, CustomStringConvertible {
    public let name: String
    public let arc: StoryArc
    public let number: Int
    public let id: UUID

    internal init(name: String, arc: StoryArc, number: Int, id: UUID) {
        self.name = name
        self.arc = arc
        self.number = number
        self.id = id
    }

    public static func all() -> [Episode] {
        guard let url = Bundle.module.url(forResource: "episodes", withExtension: "json") else { return [] }
        guard let data = try? Data(contentsOf: url) else { return [] }
        let decoder = JSONDecoder()
        guard let episodes = try? decoder.decode([Episode].self, from: data) else { return [] }
        return episodes
    }

    public var description: String {
        return "\(arc), \(number) - \(name)"
    }
}

extension Episode: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Episode: Comparable {
    public static func <(lhs: Episode, rhs: Episode) -> Bool {
        return (lhs.arc.order, lhs.number) < (rhs.arc.order, rhs.number)
    }
}

extension Episode: Equatable {
    public static func ==(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.id == rhs.id
    }
}
