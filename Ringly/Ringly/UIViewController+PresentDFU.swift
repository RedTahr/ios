import ReactiveSwift
import Result
import RinglyAPI
//import RinglyDFU
import RinglyKit

extension UIViewController
{
    /// Presents a DFU controller from the view controller.
    ///
    /// - Parameters:
    ///   - services: The services to use for DFU.
    ///   - peripheral: The peripheral to update.
    ///   - packageSource: The package source to retrieve the DFU package from.
    @nonobjc private func presentDFU(services: Services, peripheral: RLYPeripheral, _: NSNull)
    {
    }


    /// Presents a DFU controller from the view controller, after loading a firmware result from `services`.
    ///
    /// - Parameters:
    ///   - services: The services to use for DFU.
    ///   - peripheral: The peripheral to load a firmware update for and update.
    @nonobjc func presentDFU(services: Services, peripheral: RLYPeripheral)
    {
    }
}

extension ServicesViewController
{
    /// Presents a DFU controller from the view controller, using the view controller's services.
    ///
    /// - Parameters:
    ///   - peripheral: The peripheral to update.
    ///   - firmwareResult: The firmware result to use.
    @nonobjc func presentDFU(peripheral: RLYPeripheral, _: NSNull)
    {
    }
}

enum PresentDFUError: Int, Error
{
    case noUpdateAvailable
    case timeout
}

extension PresentDFUError: CustomNSError
{
    static let domain = "PresentDFUError"
}

extension PresentDFUError: LocalizedError
{
    var localizedDescription: String { return tr(.uhOh) }

    var failureReason: String?
    {
        switch self
        {
        case .noUpdateAvailable:
            return "No update available."
        case .timeout:
            return "Timed out"
        }
    }
}
