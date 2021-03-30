public enum StoryArc: String, CaseIterable, Codable {
    case Empire, Warzone, Allies, Wasteland, Vengeance, Freedom, Spectres
    case Starfleet2409Tutorial = "Starfleet Tutorial (2409)"
    case StarfleetTOSTutorial = "Starfleet Tutorial (TOS)"
    case StarfleetDSCTutorial = "Starfleet Tutorial (DSC)"
    case KlingonTutorial = "Klingon Tutorial"
    case RomulanTutorial = "Romulan Tutorial"
    case DominionTutorial = "Engineered for War"
    case AgentsOfYesterday = "Agents of Yesterday"
    case KlingonWar = "Klingon War"
    case RomulanMystery = "Romulan Mystery"
    case FekIhriReturn = "Fek'Ihri Return"
    case FromTheAshes = "From the Ashes"
    case InShadows = "In Shadows"
    case CloakedIntentions = "Cloaked Intentions"
    case CardassianStruggle = "Cardassian Struggle"
    case BorgAdvance = "Borg Advance"
    case NewRomulus = "New Romulus"
    case DysonSphere = "The Dyson Sphere"
    case DeltaQuadrant = "Delta Quadrant"
    case IconianWar = "Iconian War"
    case YesterdaysWar = "Yesterday's War"
    case FutureProof = "Future Proof"
    case NewFrontiers = "New Frontiers"
    case GammaQuadrant = "Gamma Quadrant"
    case AgeOfDiscovery = "Age of Discovery"
    case JUlasDiscovery = "J'Ula's Discovery"
    case KlingonCivilWar = "Klingon Civil War"
    case The2800 = "Lost Dominion: The 2800"
    case ColdWar = "Cold War"

    static var crossFaction: [StoryArc] {
        return [
            .CloakedIntentions, .CardassianStruggle, .The2800,
            .BorgAdvance, .ColdWar, .NewRomulus, .DysonSphere,
            .DeltaQuadrant, .IconianWar, .YesterdaysWar, .FutureProof,
            .NewFrontiers, .GammaQuadrant, .AgeOfDiscovery,
            .JUlasDiscovery, .KlingonCivilWar
        ]
    }

    var order: Int {
        switch self {
            case .Starfleet2409Tutorial, .StarfleetTOSTutorial, .StarfleetDSCTutorial: return 1
            case .KlingonTutorial, .RomulanTutorial, .DominionTutorial: return 1
            case .AgentsOfYesterday, .Empire, .FromTheAshes: return 2
            case .KlingonWar, .Warzone, .Allies: return 3
            case .FekIhriReturn, .InShadows: return 4
            case .Spectres: return 5
            case .Wasteland: return 6
            case .RomulanMystery, .Vengeance: return 7
            case .Freedom: return 8
            case .CloakedIntentions: return 9
            case .CardassianStruggle: return 10
            case .The2800: return 11
            case .BorgAdvance: return 12
            case .ColdWar: return 13
            case .NewRomulus: return 14
            case .DysonSphere: return 15
            case .DeltaQuadrant: return 16
            case .IconianWar: return 17
            case .YesterdaysWar: return 18
            case .FutureProof: return 19
            case .NewFrontiers: return 20
            case .GammaQuadrant: return 21
            case .AgeOfDiscovery: return 22
            case .JUlasDiscovery: return 23
            case .KlingonCivilWar: return 24
        }
    }
}

extension StoryArc: Comparable {
    public static func <(lhs: StoryArc, rhs: StoryArc) -> Bool {
        return lhs.order < rhs.order
    }
}

extension StoryArc: CustomStringConvertible {
    public var description: String {
        return self.rawValue
    }
}
