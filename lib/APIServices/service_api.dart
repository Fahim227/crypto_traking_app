
import 'app_services.dart';
import 'app_services_impl.dart';

class ServiceAPI {
  // create service instance
  static AppServicesImplement? _service;

  static AppServices? get APIService {
    if (_service == null) {
      _service = AppServicesImplement();
    }
    return _service;
  }
}