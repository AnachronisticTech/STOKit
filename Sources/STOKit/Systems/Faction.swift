public enum Faction: String, CaseIterable, Codable {
    case Starfleet2409 = "Starfleet (2409)"
    case StarfleetTOS = "Starfleet (TOS)"
    case StarfleetDSC = "Starfleet (DSC)"
    case KDF = "Klingon Defence Force"
    case RomulanFED = "Romulan (FED Aligned)"
    case RomulanKDF = "Romulan (KDF Aligned)"
    case DominionFED = "Dominion (FED Aligned)"
    case DominionKDF = "Dominion (KDF Aligned)"

    public var arcs: [StoryArc] {
        switch self {
            case .Starfleet2409: return [
                    .Starfleet2409Tutorial,
                    .KlingonWar,
                    .RomulanMystery
                ] + StoryArc.crossFaction
            case .StarfleetTOS: return [
                    .StarfleetTOSTutorial,
                    .AgentsOfYesterday,
                    .KlingonWar,
                    .RomulanMystery
                ] + StoryArc.crossFaction
            case .StarfleetDSC: return [
                    .StarfleetDSCTutorial,
                    .KlingonWar,
                    .RomulanMystery
                ] + StoryArc.crossFaction
            case .KDF: return [
                    .KlingonTutorial,
                    .Empire,
                    .Warzone,
                    .FekIhriReturn
                ] + StoryArc.crossFaction
            case .RomulanFED: return [
                    .RomulanTutorial,
                    .FromTheAshes,
                    .Allies,
                    .InShadows,
                    .Wasteland,
                    .Vengeance,
                    .Freedom
                ] + StoryArc.crossFaction
            case .RomulanKDF: return [
                    .RomulanTutorial,
                    .FromTheAshes,
                    .Allies,
                    .InShadows,
                    .Wasteland,
                    .Vengeance,
                    .Freedom
                ] + StoryArc.crossFaction
            case .DominionFED: return [
                    .DominionTutorial
                ] + StoryArc.crossFaction
            case .DominionKDF: return [
                    .DominionTutorial
                ] + StoryArc.crossFaction
        }
    }

    public var permittedOfficerFactions: [Faction] {
        switch self {
            case .Starfleet2409, .StarfleetTOS, .StarfleetDSC:
                return [.Starfleet2409, .StarfleetTOS, .StarfleetDSC]
            case .KDF: return [.KDF]
            case .RomulanFED:
                return [.Starfleet2409, .StarfleetTOS, .StarfleetDSC, .RomulanFED]
            case .RomulanKDF: return [.KDF, .RomulanKDF]
            case .DominionFED:
                return [.Starfleet2409, .StarfleetTOS, .StarfleetDSC, .DominionFED]
            case .DominionKDF: return [.KDF, .DominionKDF]
        }
    }
}

extension Faction: CustomStringConvertible {
    public var description: String {
        return self.rawValue
    }
}
