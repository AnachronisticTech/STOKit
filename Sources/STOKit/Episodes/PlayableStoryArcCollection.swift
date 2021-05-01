import struct Foundation.UUID

public struct PlayableStoryArcCollection: Codable {
    public typealias StoryArcs = [PlayableEpisode]

    private var episodes = StoryArcs()

    init(for faction: Faction) {
        self.episodes = Episode.all()
            .filter { episode in
                faction.arcs.contains(episode.arc)
            }
            .map { PlayableEpisode(episode: $0, played: false) }
    }

    init(with episodes: [PlayableEpisode]) {
        self.episodes = episodes
    }
    
    public subscript(arc: StoryArc) -> [PlayableEpisode] {
        get {
            return episodes
                .filter { episode in
                    episode.arc == arc
                }
                .sorted(by: { $0.number < $1.number })
        }
    }

    public subscript(episode: Episode) -> Bool {
        get {
            return episodes.first(where: { $0 == episode })?.played ?? false
        }
        set {
            guard let index = episodes.firstIndex(where: { $0 == episode }) else { return }
            episodes[index].played = newValue
        }
    }
    
    public var completed: [PlayableEpisode] {
        return episodes
            .filter { $0.played }
            .sorted()
    }

    public var incomplete: [PlayableEpisode] {
        return episodes
            .filter { !$0.played }
            .sorted()
    }
}

extension PlayableStoryArcCollection: Collection {
    public typealias Index = StoryArcs.Index
    public typealias Element = StoryArcs.Element

    public var startIndex: Index { return episodes.startIndex }
    public var endIndex: Index { return episodes.endIndex }

    public subscript(index: Index) -> Element {
        get { return episodes[index] }
    }

    public func index(after i: Index) -> Index {
        return episodes.index(after: i)
    }
}
