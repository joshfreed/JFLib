import Foundation
import JFLib_Services

extension Mediator {
    public func registerHandler<CommandType: JFMCommand, HandlerType: JFMCommandHandler>(
        _ handlerType: HandlerType.Type,
        for commandType: CommandType.Type
    ) {
        registerHandler(try! JFServices.resolve() as HandlerType, for: CommandType.self)
    }

    public func registerHandler<QueryType: JFMQuery, HandlerType: JFMQueryHandler>(
        _ handlerType: HandlerType.Type,
        for queryType: QueryType.Type
    ) {
        registerHandler(try! JFServices.resolve() as HandlerType, for: QueryType.self)
    }
}
