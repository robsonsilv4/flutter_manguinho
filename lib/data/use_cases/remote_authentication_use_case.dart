import 'package:meta/meta.dart';

import '../../domain/use_cases/use_cases.dart';
import '../http/http.dart';

class RemoteAuthenticationUseCase {
  final HttpClient httpClient;
  final String url;

  RemoteAuthenticationUseCase({
    @required this.httpClient,
    @required this.url,
  });

  Future<void> auth(AuthenticationParams params) async {
    await httpClient.request(
      url: url,
      method: 'post',
      body: params.toJson(),
    );
  }
}
