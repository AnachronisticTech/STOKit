public struct STOPlayableStoryArcCollection: Codable {
    public typealias StoryArcs = [STOPlayableEpisode]

    private var episodes = StoryArcs()

    init(for faction: STOFaction) {
        self.episodes = STOEpisode.all()
            .filter { episode in
                faction.arcs.contains(episode.arc)
            }
            .map { STOPlayableEpisode(episode: $0, played: false) }
    }

    init(with episodes: [STOPlayableEpisode]) {
        self.episodes = episodes
    }
    
    public subscript(arc: STOStoryArc) -> [STOPlayableEpisode] {
        get {
            return episodes
                .filter { episode in
                    episode.arc == arc
                }
                .sorted(by: { $0.number < $1.number })
        }
    }

    public subscript(episode: STOEpisode) -> Bool {
        get {
            return episodes.first(where: { $0 == episode })?.played ?? false
        }
        set {
            guard let index = episodes.firstIndex(where: { $0 == episode }) else { return }
            episodes[index].played = newValue
        }
    }
    
    public var completed: [STOPlayableEpisode] {
        return episodes
            .filter { $0.played }
            .sorted(by: { ($0.arc.order, $0.number) < ($1.arc.order, $1.number) })
    }

    public var incomplete: [STOPlayableEpisode] {
        return episodes
            .filter { !$0.played }
            .sorted(by: { ($0.arc.order, $0.number) < ($1.arc.order, $1.number) })
    }
}

extension STOPlayableStoryArcCollection: Collection {
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
