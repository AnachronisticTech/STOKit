import Foundation

public struct STOPlayableStoryArcCollection: Codable {
    public typealias StoryArcs = [STOEpisode : Bool]

    private var story = StoryArcs()

    init(_ story: StoryArcs) {
        self.story = story
    }
    
    public subscript(arc: STOStoryArc) -> [(STOEpisode, Bool)] {
        get {
            return story
                .filter { episode, _ in
                    episode.arc == arc
                }
                .sorted(by: { $0.key.number < $1.key.number })
        }
    }

    public subscript(episode: STOEpisode) -> Bool {
        get { return story[episode] ?? false }
        set { story[episode] = newValue }
    }
    
    public var completed: [STOEpisode] {
        return story
            .filter { $0.1 }
            .map { $0.0 }
            .sorted(by: { ($0.arc.order, $0.number) < ($1.arc.order, $1.number) })
    }

    public var incomplete: [STOEpisode] {
        return story
            .filter { !$0.1 }
            .map { $0.0 }
            .sorted(by: { ($0.arc.order, $0.number) < ($1.arc.order, $1.number) })
    }
}

extension STOPlayableStoryArcCollection: Collection {
    public typealias Index = StoryArcs.Index
    public typealias Element = StoryArcs.Element

    public var startIndex: Index { return story.startIndex }
    public var endIndex: Index { return story.endIndex }

    public subscript(index: Index) -> Element {
        get { return story[index] }
    }

    public func index(after i: Index) -> Index {
        return story.index(after: i)
    }
}

extension STOPlayableStoryArcCollection: ExpressibleByDictionaryLiteral {
    public typealias Key = STOEpisode
    public typealias Value = Bool

    public init(dictionaryLiteral elements: (Key, Value)...) {
        for (episode, status) in elements {
            story[episode] = status
        }
    }
}
