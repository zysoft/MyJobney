//
//  SwiftDataStorageService.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/21/23.
//

import Foundation
import SwiftData
import OSLog
import Factory

struct SwiftDataStorageService: StorageService {
    var autosave: Bool {
        didSet {
            modelContext.autosaveEnabled = autosave
            guard autosave else { return }
            if modelContext.hasChanges {
                persistChanges()
            }
        }
    }
    private var modelContext: ModelContext
    
    init(modelContainer: ModelContainer = Dependency.Global[\.modelContainer], autosave: Bool = true) {
        self.autosave = autosave
        modelContext = ModelContext(modelContainer)
        modelContext.autosaveEnabled = autosave
    }
    
    func retrieve<Model>(byId id: PersistentIdentifier) -> Model? where Model : PersistentModel {
        modelContext.model(for: id) as? Model
    }
    
    func query<Model>(withPredicate predicate: Predicate<Model>, orderBy order: [SortDescriptor<Model>], limit: Int?, offset: Int?) -> [Model] where Model : PersistentModel {
        var fetchDescriptor = FetchDescriptor(predicate: predicate, sortBy: order)
        fetchDescriptor.fetchLimit = limit
        fetchDescriptor.fetchOffset = offset
        let models = try? modelContext.fetch(fetchDescriptor)
        // FIXME: Need error processing
        return models ?? []
    }
    func delete<Model>(_ model: Model) where Model : PersistentModel {
        modelContext.delete(model)
        if autosave {
            persistChanges()
        }
    }
    func delete<Model>(_ models: [Model]) where Model : PersistentModel {
        models.forEach(modelContext.delete)
        if autosave {
            persistChanges()
        }
    }
    func store<Model>(_ model: Model) where Model : PersistentModel {
        if nil == model.modelContext {
            modelContext.insert(model)
        }
        if autosave {
            persistChanges()
        }
    }
    func store<Model>(_ models: [Model]) where Model : PersistentModel {
        models.forEach {
            if nil == $0.modelContext {
                modelContext.insert($0)
            }
        }
        if autosave {
            persistChanges()
        }
    }
    func persistChanges() {
        do {
            try modelContext.save()
        } catch {
            // FIXME: Handle error
        }
    }
}

// MARK: -


extension SwiftDataStorageService {
    static nonisolated func newModelContainer(inMemory: Bool = false) -> ModelContainer {
        let schema = Schema([
            JobApplication.self,
            JobApplicationStatusRecord.self,
            Company.self,
            FiledDocument.self,
            Resume.self,
            ExperienceRecord.self,
            EducationRecord.self,
            Skill.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: inMemory)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            // FIXME: Handle error
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}


// MARK: - Dependency Injection for ModelContainer


extension Dependency.Global {
    var modelContainer: Factory<ModelContainer> {
        self {
#if DEBUG
            if ExecutionEnvironment.current != .production {
                return SwiftDataStorageService.newModelContainer(inMemory: true)
            }
#endif
            return SwiftDataStorageService.newModelContainer()
        }
        .singleton
    }
}

