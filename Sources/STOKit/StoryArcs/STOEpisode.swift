import Foundation

public struct STOEpisode: Codable, Hashable {
    public var name: String
    public var arc: STOStoryArc
    public var number: Int

    public static func all() -> [STOEpisode] {
        guard let url = Bundle.module.url(forResource: "episodes", withExtension: "json") else { return [] }
        guard let data = try? Data(contentsOf: url) else { return [] }
        let decoder = JSONDecoder()
        guard let episodes = try? decoder.decode([STOEpisode].self, from: data) else { return [] }
        return episodes
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(number)
        hasher.combine(arc)
    }
}
