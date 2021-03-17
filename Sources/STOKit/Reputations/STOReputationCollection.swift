public struct STOReputationCollection: Codable {
    public typealias Reputations = [STOReputation]

    private let reputations: Reputations

    init() {
        self.reputations = STOReputationOrganization.allCases.map { organization in
            STOReputation(organization: organization)
        }
    }

    internal init(_ reputations: [STOReputation]) {
        self.reputations = reputations
    }

    public subscript(organization: STOReputationOrganization) -> STOReputation {
        get { return reputations.filter({ $0.organization == organization }).first! }
    }
}

extension STOReputationCollection: Collection {
    public typealias Index = Reputations.Index
    public typealias Element = Reputations.Element

    public var startIndex: Index { return reputations.startIndex }
    public var endIndex: Index { return reputations.endIndex }

    public subscript(index: Index) -> Element {
        get { return reputations[index] }
    }

    public func index(after i: Index) -> Index {
        return reputations.index(after: i)
    }
}
