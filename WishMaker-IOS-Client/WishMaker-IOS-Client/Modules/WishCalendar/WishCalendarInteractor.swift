protocol WishCalendarInteractorProtocol: AnyObject {
    func fetchEvents()
}

protocol WishCalendarInteractorOutputProtocol: AnyObject {
    func didFetchEvents(_ events: [WishEvent])
}

class WishCalendarInteractor: WishCalendarInteractorProtocol {
    weak var presenter: WishCalendarInteractorOutputProtocol?
    
    func fetchEvents() {
        let events = [
            WishEvent(title: "Event Title 1", description: "Event description", startDate: "2024-10-01", endDate: "2024-11-01"),
            WishEvent(title: "Event Title 2", description: "Event description", startDate: "2024-12-03", endDate: "2024-12-05"),
        ]
        presenter?.didFetchEvents(events)
    }
}
