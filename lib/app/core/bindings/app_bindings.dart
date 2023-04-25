import 'package:crud_agendamento/app/core/http_clients/get_client.dart';
import 'package:crud_agendamento/app/core/http_clients/rest_client.dart';
import 'package:get/get.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RestClient>(() => GetClient(), fenix: true);
  }
}
