//
//  QueroSerMBUITests.swift
//  QueroSerMBUITests
//
//  Created by Hundily Cerqueira on 18/11/25.
//

import XCTest

final class HomeViewControllerUITests: XCTestCase {

    var app: XCUIApplication!

    // MARK: - Setup Base
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
    }

    private func mockExchangeName(index: Int) -> String {
        return "Exchange Test \(index)"
    }

    func test_01_loadingStateDisplaysLoadingCell() throws {
        // 1. Configura o estado inicial: .loading
        app.launchArguments.append("-isUITesting")
        app.launchArguments.append("-initialState")
        app.launchArguments.append("loading")
        app.launch()

        // 2. Verifica se a célula de loading está visível
        // Assumimos que o HomeLoadingCell tem um Accessibility Label de "loading_indicator" ou similar.
        let loadingIndicator = app.otherElements["loading_indicator"].firstMatch
        let loadingText = app.staticTexts["Carregando dados..."] // Ou o texto que a HomeLoadingCell exibe
        
        XCTAssertTrue(loadingIndicator.exists, "O indicador de loading (ou célula) deve estar visível no início.")
        XCTAssertTrue(loadingText.exists, "O texto de carregamento deve estar visível.")
    }

    // Teste 2: Verifica o estado de sucesso
    func test_02_loadedStateDisplaysExchangeList() throws {
        // 1. Configura o estado inicial: .loaded com dados mockados
        app.launchArguments.append("-isUITesting")
        app.launchArguments.append("-initialState")
        app.launchArguments.append("loaded")
        
        // Argumento extra para simular 10 itens carregados (se o app suportar)
        app.launchArguments.append("-mockItemCount")
        app.launchArguments.append("10")
        app.launch()

        // 2. Verifica a existência da UITableView
        let tableView = app.tables.firstMatch
        XCTAssertTrue(tableView.exists, "A tabela de exchanges deve estar presente.")
        
        // 3. Verifica o primeiro e o último item da lista (verificação de conteúdo)
        // O nome da célula deve ser o Nome da Exchange (definido pela célula.textLabel ou Accessibility Label).
        let firstItem = tableView.cells.element(boundBy: 0)
        XCTAssertTrue(firstItem.exists, "A primeira célula da lista deve estar visível.")
        
        // Verifica o nome do primeiro item (ex: o label do título da Exchange)
        // Nota: Substitua "Coinmate" pelo Accessibility Label que a célula HomeListCell está usando para o título.
        let firstExchangeName = firstItem.staticTexts["Coinmate"].firstMatch
        XCTAssertTrue(firstExchangeName.exists, "A primeira Exchange deve ser exibida corretamente.")
        
        // 4. Teste de Scroll
        let lastItem = tableView.cells.element(boundBy: 9)
        tableView.swipeUp()
        XCTAssertTrue(lastItem.exists, "O décimo item deve ser visível após o scroll.")
    }
    
    // Teste 3: Verifica o estado de erro e a ação de tentar novamente
    func test_03_ErrorStateAndRetryInteraction() throws {
        // 1. Configura o estado inicial: .error
        app.launchArguments.append("-isUITesting")
        app.launchArguments.append("-initialState")
        app.launchArguments.append("error")
        app.launch()

        // 2. Verifica se a célula de erro e o botão 'Tentar Novamente' estão visíveis
        let errorMessage = app.staticTexts["Error ao carregar os dados."].firstMatch // O texto que você passou para o configure()
        let retryButton = app.buttons["Tentar Novamente"].firstMatch
        
        XCTAssertTrue(errorMessage.exists, "A mensagem de erro deve ser exibida.")
        XCTAssertTrue(retryButton.exists, "O botão Tentar Novamente deve estar visível.")
        
        // 3. Simula a interação: Toca no botão
        retryButton.tap()
        
        // 4. Verifica se o app voltou para o estado de loading (ou se chamou a API novamente)
        // O estado de loading deve ser reexibido.
        let loadingIndicator = app.otherElements["loading_indicator"].firstMatch
        XCTAssertTrue(loadingIndicator.exists, "Após o clique em 'Tentar Novamente', o indicador de loading deve aparecer.")
    }
}
