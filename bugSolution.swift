func fetchData() async throws -> Data {
    let url = URL(string: "https://api.example.com/data")!
    let (data, response) = try await URLSession.shared.data(from: url)

    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        throw URLError(.badServerResponse)
    }

    return data
}

Task { 
    do {
        let data = try await fetchData()
        // Process data
    } catch let error as URLError {
        switch error.code {
        case .badServerResponse: 
            print("Server error: \(error.localizedDescription)")
            // Handle bad server response
        case .notConnectedToInternet: 
            print("No internet connection: \(error.localizedDescription)")
            // Handle no internet error
        default: 
            print("Unknown error: \(error.localizedDescription)")
            // Handle other errors
        }
    } catch {
        print("An unknown error occurred: \(error)")
    }
}