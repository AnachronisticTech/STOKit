public enum STOFaction: String, CaseIterable, Codable {
    case Starfleet2409 = "Starfleet (2409)"
    case StarfleetTOS = "Starfleet (TOS)"
    case StarfleetDSC = "Starfleet (DSC)"
    case KDF = "Klingon Defence Force"
    case RomulanFED = "Romulan (FED Aligned)"
    case RomulanKDF = "Romulan (KDF Aligned)"
    case DominionFED = "Dominion (FED Aligned)"
    case DominionKDF = "Dominion (KDF Aligned)"

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

extension STOFaction: CustomStringConvertible {
    public var description: String {
        return self.rawValue
    }
}
