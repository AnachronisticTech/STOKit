public enum STOFaction: String, CaseIterable, Codable, Hashable {
    case Starfleet2409, StarfleetTOS, StarfleetDSC
    case KDF, RomulanFED, RomulanKDF, DominionFED, DominionKDF

    public var description: String {
        switch self {
            case .Starfleet2409: return "Starfleet (2409)"
            case .StarfleetTOS: return "Starfleet (TOS)"
            case .StarfleetDSC: return "Starfleet (DSC)"
            case .KDF: return "Klingon Defence Force"
            case .RomulanFED: return "Romulan (FED Aligned)"
            case .RomulanKDF: return "Romulan (KDF Aligned)"
            case .DominionFED: return "Dominion (FED Aligned)"
            case .DominionKDF: return "Dominion (KDF Aligned)"
        }
    }

    public var arcs: [STOStoryArc] {
        switch self {
            case .Starfleet2409: return [
                    .Starfleet2409Tutorial,
                    .KlingonWar,
                    .RomulanMystery
                ] + STOStoryArc.crossFaction
            case .StarfleetTOS: return [
                    .StarfleetTOSTutorial,
                    .AgentsOfYesterday,
                    .KlingonWar,
                    .RomulanMystery
                ] + STOStoryArc.crossFaction
            case .StarfleetDSC: return [
                    .StarfleetDSCTutorial,
                    .KlingonWar,
                    .RomulanMystery
                ] + STOStoryArc.crossFaction
            case .KDF: return [
                    .KlingonTutorial,
                    .Empire,
                    .Warzone,
                    .FekIhriReturn
                ] + STOStoryArc.crossFaction
            case .RomulanFED: return [
                    .RomulanTutorial,
                    .FromTheAshes,
                    .Allies,
                    .InShadows,
                    .Wasteland,
                    .Vengeance,
                    .Freedom
                ] + STOStoryArc.crossFaction
            case .RomulanKDF: return [
                    .RomulanTutorial,
                    .FromTheAshes,
                    .Allies,
                    .InShadows,
                    .Wasteland,
                    .Vengeance,
                    .Freedom
                ] + STOStoryArc.crossFaction
            case .DominionFED: return [
                    .DominionTutorial
                ] + STOStoryArc.crossFaction
            case .DominionKDF: return [
                    .DominionTutorial
                ] + STOStoryArc.crossFaction
        }
    }
}
