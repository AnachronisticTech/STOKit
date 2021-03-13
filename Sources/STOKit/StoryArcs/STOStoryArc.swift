public enum STOStoryArc: String, CaseIterable, Codable, Hashable {
    case Starfleet2409Tutorial, StarfleetTOSTutorial, StarfleetDSCTutorial
    case KlingonTutorial, RomulanTutorial, DominionTutorial
    case AgentsOfYesterday, KlingonWar, RomulanMystery
    case Empire, Warzone, FekIhriReturn
    case FromTheAshes, Allies, InShadows, Wasteland, Vengeance, Freedom
    case CloakedIntentions, CardassianStruggle, BorgAdvance, NewRomulus
    case DysonSphere, DeltaQuadrant, IconianWar, YesterdaysWar, FutureProof
    case NewFrontiers, GammaQuadrant, AgeOfDiscovery, JUlasDiscovery, KlingonCivilWar
    case Spectres, The2800, ColdWar

    public var description: String {
        switch self {
            case .Starfleet2409Tutorial: return "Starfleet Tutorial (2409)"
            case .StarfleetTOSTutorial: return "Starfleet Tutorial (TOS)"
            case .StarfleetDSCTutorial: return "Starfleet Tutorial (DIS)"
            case .KlingonTutorial: return "Klingon Tutorial"
            case .RomulanTutorial: return "Romulan Tutorial"
            case .DominionTutorial: return "Engineered for War"
            case .AgentsOfYesterday: return "Agents of Yesterday"
            case .KlingonWar: return "Klingon War"
            case .RomulanMystery: return "Romulan Mystery"
            case .FekIhriReturn: return "Fek'Ihri Return"
            case .FromTheAshes: return "From the Ashes"
            case .InShadows: return "In Shadows"
            case .CloakedIntentions: return "Cloaked Intentions"
            case .CardassianStruggle: return "Cardassian Struggle"
            case .BorgAdvance: return "Borg Advance"
            case .NewRomulus: return "New Romulus"
            case .DysonSphere: return "The Dyson Sphere"
            case .DeltaQuadrant: return "Delta Quadrant"
            case .IconianWar: return "Iconian War"
            case .YesterdaysWar: return "Yesterday's War"
            case .FutureProof: return "Future Proof"
            case .NewFrontiers: return "New Frontiers"
            case .GammaQuadrant: return "Gamma Quadrant"
            case .AgeOfDiscovery: return "Age of Discovery"
            case .JUlasDiscovery: return "J'Ula's Discovery"
            case .KlingonCivilWar: return "Klingon Civil War"
            case .The2800: return "Lost Dominion: The 2800"
            case .ColdWar: return "Cold War"
            case .Empire, .Warzone, .Allies, .Wasteland: return self.rawValue
            case .Vengeance, .Freedom, .Spectres: return self.rawValue
        }
    }

    public static var crossFaction: [STOStoryArc] {
        return [
            .CloakedIntentions, .CardassianStruggle, .The2800,
            .BorgAdvance, .ColdWar, .NewRomulus, .DysonSphere,
            .DeltaQuadrant, .IconianWar, .YesterdaysWar, .FutureProof,
            .NewFrontiers, .GammaQuadrant, .AgeOfDiscovery,
            .JUlasDiscovery, .KlingonCivilWar
        ]
    }

    public var order: Int {
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
