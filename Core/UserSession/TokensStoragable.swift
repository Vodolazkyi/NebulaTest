import Foundation

public protocol TokensStoragable {
    
    func obtain() -> SessionInfo?
    func save(data: SessionInfo)
    func update(token: String)
    func clean()
}
