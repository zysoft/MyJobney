//
//  BasicInformationView.swift
//  My JobneyTests
//
//  Created by Iurii Zisin on 1/2/24.
//

import XCTest
import SwiftData
@testable import My_Jobney

@MainActor
final class ApplicationFormView_BasicInformationViewVMTest: XCTestCase {
    @TestBinding private var position = ""
    @TestBinding private var company: Company?
    private var vm = ApplicationFormView.BasicInformationView.ViewModel(position: .constant(""), company: .constant(nil))

    override func setUpWithError() throws {
        Dependency.Service.shared.storage.register {
            TestStorage()
        }
        position = ""
        company = nil
        vm = ApplicationFormView.BasicInformationView.ViewModel(position: $position, company: $company)
    }

    /// Test verifies that the auto-completer queries the storage and presents the results retrieved from the storage
    /// based on the provided string.
    func testAutoCompletion() async throws {
        var companies = await vm.companies(matching: "test")
        XCTAssertEqual(2, companies.count)
        XCTAssertTrue(companies.contains { $0.name == "Test Company A" })
        XCTAssertTrue(companies.contains { $0.name == "Test Company B" })
        companies = await vm.companies(matching: "ABCD")
        XCTAssertEqual(0, companies.count)
    }
    
    /// Testing company assignment via view model.
    ///
    /// Tests that assigning a company to the view model accomplishes the following:
    ///  - updates `company` via the binding.
    ///  - updates `vm.companyName` according to the `company` set.
    func testCompanySet() async throws {
        let companyName = "Company \(Int.random(in: 0..<100))"
        XCTAssertNotEqual(companyName, vm.companyName)
        vm.company = .init(name: companyName)
        XCTAssertEqual(companyName, company?.name)
        XCTAssertEqual(companyName, vm.companyName)
    }
    
    /// Tests that assigning a `position` value through view model actually changes the bound value.
    func testPositionSet() async throws {
        let position = "Position \(Int.random(in: 0..<100))"
        XCTAssertNotEqual(position, vm.companyName)
        vm.position = position
        XCTAssertEqual(position, self.position)
    }
}


/// Test storage implementation returning specific companies for the test.
fileprivate struct TestStorage: StorageService {

    var autosave = false

    func retrieve<Model>(byId: PersistentIdentifier) -> Model? where Model : PersistentModel {
        fatalError("Storage `retrieve` method is not expected to be called")
    }
    
    func query<Model>(withPredicate predicate: Predicate<Model>, orderBy order: [SortDescriptor<Model>], limit: Int?, offset: Int?) -> [Model] where Model : PersistentModel {
        return try! ([
            Company(name: "Test Company A"),
            Company(name: "Test Company B")
        ] as! [Model])
            .filter(predicate)
    }
    
    func store<Model>(_ model: Model) where Model : PersistentModel {
        fatalError("Storage `store` method is not expected to be called")
    }
    func store<Model>(_ models: [Model]) where Model : PersistentModel {
        fatalError("Storage `store` method is not expected to be called")
    }
    func delete<Model>(_ model: Model) where Model : PersistentModel {
        fatalError("Storage `delete` method is not expected to be called")
    }
    func delete<Model>(_ model: [Model]) where Model : PersistentModel {
        fatalError("Storage `delete` method is not expected to be called")
    }
    func persistChanges() {
        // Changes are just in RAM
    }
}
