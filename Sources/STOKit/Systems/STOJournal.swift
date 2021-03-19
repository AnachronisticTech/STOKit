public struct STOJournal {
    public var episodes: STOPlayableStoryArcCollection

    public init(faction: STOFaction) {
        self.episodes = STOPlayableStoryArcCollection(for: faction)
    }
}

extension STOJournal: Codable {
    enum CodingKeys: CodingKey {
        case episodes
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var episodeContainer = try container.nestedUnkeyedContainer(forKey: .episodes)
        var episodes = [STOPlayableEpisode]()
        while !episodeContainer.isAtEnd {
            episodes.append(try episodeContainer.decode(STOPlayableEpisode.self))
        }
        self.episodes = STOPlayableStoryArcCollection(with: episodes)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var story = container.nestedUnkeyedContainer(forKey: .episodes)
        try episodes.forEach { episode in
            try story.encode(episode)
        }
    }
}
