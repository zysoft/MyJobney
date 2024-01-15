//
//  StorageService.swift
//  My Jobney
//
//  Created by Iurii Zisin on 1/4/24.
//

import Foundation
import SwiftData
import Factory

protocol StorageService {
    var autosave: Bool { get set }
    func retrieve<Model>(byId: PersistentIdentifier) -> Model? where Model: PersistentModel
    func query<Model>(withPredicate predicate: Predicate<Model>, orderBy order: [SortDescriptor<Model>], limit: Int?, offset: Int?) -> [Model] where Model : PersistentModel
    func delete<Model>(_ model: Model) where Model : PersistentModel
    func delete<Model>(_ model: [Model]) where Model : PersistentModel
    func store<Model>(_ model: Model) where Model : PersistentModel
    func store<Model>(_ models: [Model]) where Model : PersistentModel
    func persistChanges()
}

extension StorageService {
    func query<Model>(withPredicate predicate: Predicate<Model> = .true, orderBy order: [SortDescriptor<Model>] = [], limit: Int? = nil, offset: Int? = nil) -> [Model] where Model : PersistentModel {
        query(withPredicate: predicate, orderBy: order, limit: limit, offset: offset)
    }
}

// MARK: - Dependency Injection

extension Dependency.Service {
    
    /// Storage service for persisting data locally.
    ///
    /// Makes an instance for every context, which will introduce a local `ModelContext` so any operations
    /// are performed within the scope of the caller avoiding data races.
    var storage: Factory<StorageService> {
        self {
            SwiftDataStorageService(modelContainer: Dependency.Global[\.modelContainer])
        }
    }
}
