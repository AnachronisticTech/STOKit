public protocol STODamageType {}

public enum STOEnergyDamageType: String, STODamageType, Codable {
    case Phaser, Disruptor, Plasma
    case Tetryon, Polaron, Antiproton
}

public enum STOPhysicalDamageType: String, STODamageType, Codable {
    case Kinetic, Physical
}

public enum STOTorpedoKineticDamageType: String, STODamageType, Codable {
    case Photon, Quantum, Plasma // Apparently vanilla Plasma torpedoes do kinetic damage
    case Transphasic, Chroniton, Tricobalt
}

// public enum STOTorpedoEnergyDamageType: String, STODamageType, Codable {
//     case Phaser, Disruptor, Plasma
//     case Tetryon, Polaron, Antiproton
// }
