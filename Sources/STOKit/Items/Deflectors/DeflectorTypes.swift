extension Deflector {
    internal static let specialTypes: [String: Deflector.Type] = {
        return _specialTypes.reduce([String: Deflector.Type]()) { (dict, type) -> [String: Deflector.Type] in
            var dict = dict
            dict[String(describing: type.self)] = type.self
            return dict
        }
    }()
    private static let _specialTypes: [Deflector.Type] = [
        // Standard types
        Deflector.self,
        GravitonDeflector.self,
        NeutrinoDeflector.self,
        PositronDeflector.self,
        TachyonDeflector.self,

        // Fleet starbase types
        AdvancedGravitonDeflector.self,
        AdvancedNeutrinoDeflector.self,
        AdvancedPositronDeflector.self,
        AdvancedTachyonDeflector.self,
        FleetAxionDeflector.self,
        FleetFermionDeflector.self,

        // Fleet colony world types
        FleetPreservationDeflector.self,
        FleetInterventionDeflector.self,

        // Reputation types
        AssimilatedDeflector.self,
        MACOGravitonDeflector.self,
        AdaptedMACOPositronDeflector.self,
        HonorGuardPositronDeflector.self,
        AdaptedHonorGuardGravitonDeflector.self,
        OmegaForceTachyonDeflector.self,
        NukaraDeflector.self,
        RemanPrototypeDeflector.self,
        RomulanPrototypeDeflector.self,
        DysonDeflector.self,
        CounterCommandDeflector.self,
        DeltaAllianceDeflector.self,
        IconianResistanceDeflector.self,
        TerranTaskForceDeflector.self,
        TemporalDefenseDeflector.self,
        LukariRestorationDeflector.self,
        PrevailingInnervatedDeflector.self,
        PrevailingBolsteredDeflector.self,
        PrevailingFortifiedDeflector.self,
        GammaSynergisticDeflector.self,
        NonBaryonicMatterDeflector.self,

        // Mission/Crafted types
        AegisDeflector.self,
        BajorDefenseDeflector.self,
        BraydonReconnaissanceDeflector.self,
        JemHadarDeflector.self,
        PolarizedParabolicDeflector.self,
        KobaliDeflector.self,
        PreeminentDeflector.self,
        SolDefenseDeflector.self,
        SolanaeDeflector.self,
        SubatomicSDeflector.self,
        TalShiarTachyonDeflector.self,
        QuantumPhaseDeflector.self,
        RevolutionaryDeflector.self
    ]
}
