public struct STOJournal: Codable {
    public var episodes: STOPlayableStoryArcCollection

    public init(faction: STOFaction) {
        self.episodes = STOEpisode.all()
            .filter { episode in 
                faction.arcs.contains(episode.arc)
            }
            .reduce(STOPlayableStoryArcCollection()) { (dict, episode) -> STOPlayableStoryArcCollection in 
                var dict = dict
                dict[episode] = false
                return dict
            }
    }
}
