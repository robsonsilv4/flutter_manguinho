import 'package:faker/faker.dart';
import 'package:flutter_manguinho/data/http/http.dart';
import 'package:flutter_manguinho/data/use_cases/use_cases.dart';
import 'package:flutter_manguinho/domain/helpers/helpers.dart';
import 'package:flutter_manguinho/domain/use_cases/use_cases.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  HttpClientSpy httpClient;
  String url;
  AuthenticationParams params;
  RemoteAuthenticationUseCase sut;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    params = AuthenticationParams(
      email: faker.internet.email(),
      password: faker.internet.password(),
    );
    sut = RemoteAuthenticationUseCase(httpClient: httpClient, url: url);
  });

  test('should call HttpClient with correct values', () async {
    await sut.auth(params);

    verify(httpClient.request(
      url: url,
      method: 'post',
      body: {
        'email': params.email,
        'password': params.password,
      },
    ));
  });

  test('should throw UnexpectedError if HttpClient returns 400', () async {
    when(
      httpClient.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
        body: anyNamed('body'),
      ),
    ).thenThrow(HttpError.badRequest);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });
}
