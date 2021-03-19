import Foundation

public class STOEpisode: Codable, CustomStringConvertible {
    public var name: String
    public var arc: STOStoryArc
    public var number: Int

    public init(name: String, arc: STOStoryArc, number: Int) {
        self.name = name
        self.arc = arc
        self.number = number
    }

    public static func all() -> [STOEpisode] {
        guard let url = Bundle.module.url(forResource: "episodes", withExtension: "json") else { return [] }
        guard let data = try? Data(contentsOf: url) else { return [] }
        let decoder = JSONDecoder()
        guard let episodes = try? decoder.decode([STOEpisode].self, from: data) else { return [] }
        return episodes
    }

    public var description: String {
        return "\(arc), \(number) - \(name)"
    }
}

extension STOEpisode: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(number)
        hasher.combine(arc)
    }
}

extension STOEpisode: Comparable {
    public static func <(lhs: STOEpisode, rhs: STOEpisode) -> Bool {
        return (lhs.arc.order, lhs.number) < (rhs.arc.order, rhs.number)
    }
}

extension STOEpisode: Equatable {
    public static func ==(lhs: STOEpisode, rhs: STOEpisode) -> Bool {
        return lhs.name == rhs.name && lhs.arc == rhs.arc && lhs.number == rhs.number
    }
}
