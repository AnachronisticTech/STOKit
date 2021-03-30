public struct Journal {
    public var episodes: PlayableStoryArcCollection

    public init(faction: Faction) {
        self.episodes = PlayableStoryArcCollection(for: faction)
    }
}

extension Journal: Codable {
    enum CodingKeys: CodingKey {
        case episodes
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var episodeContainer = try container.nestedUnkeyedContainer(forKey: .episodes)
        var episodes = [PlayableEpisode]()
        while !episodeContainer.isAtEnd {
            episodes.append(try episodeContainer.decode(PlayableEpisode.self))
        }
        self.episodes = PlayableStoryArcCollection(with: episodes)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var story = container.nestedUnkeyedContainer(forKey: .episodes)
        try episodes.forEach { episode in
            try story.encode(episode)
        }
    }
}
