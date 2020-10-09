import 'package:meta/meta.dart';

import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/use_cases/use_cases.dart';
import '../http/http.dart';

class RemoteAuthenticationParams {
  final String email;
  final String password;

  RemoteAuthenticationParams({
    @required this.email,
    @required this.password,
  });

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams params) =>
      RemoteAuthenticationParams(
        email: params.email,
        password: params.password,
      );

  Map toJson() => {'email': email, 'password': password};
}

class RemoteAuthenticationUseCase {
  final HttpClient httpClient;
  final String url;

  RemoteAuthenticationUseCase({
    @required this.httpClient,
    @required this.url,
  });

  Future<AccountEntity> auth(AuthenticationParams params) async {
    final body = RemoteAuthenticationParams.fromDomain(params).toJson();
    try {
      final response = await httpClient.request(
        url: url,
        method: 'post',
        body: body,
      );
      return AccountEntity.fromJson(response);
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.invalidCredentials
          : DomainError.unexpected;
    }
  }
}
