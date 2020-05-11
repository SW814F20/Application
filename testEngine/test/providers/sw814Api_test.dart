import 'dart:io';

import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:testEngine/src/providers/sw814Api.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void expectException(actual, String error_msg){
  return expect(
          actual,
      throwsA(
          predicate((e) =>
          e is Exception &&
              e.toString() == 'Exception: '+error_msg
          )
      )
  );
}

void main(){
  Sw814Api api;
  MockClient mock;

  setUp(() {
    mock = MockClient();
    api = Sw814Api('test.test/', client: mock);
  });

  group('Login api tests', (){
    final fakeUserResponse = http.Response(
    '{"id": 1,"username": "morten","firstName": "Morten","lastName": "Petersen","token": "fake-token"}',
    200);
    final wrongCredentialsResponse = http.Response('{"message": "Username or password is incorrect"}', 400);

    setUp((){
      when(mock.post(
          'test.test/User/Authenticate',
          body: '{"username": "morten","password": "password"}',
          encoding: captureAnyNamed('encoding'),
          headers: captureAnyNamed('headers')
      )).thenAnswer((_) async => fakeUserResponse);

      when(mock.post(
          'test.test/User/Authenticate',
          body: '{"username": "morten","password": "wrong-password"}',
          encoding: captureAnyNamed('encoding'),
          headers: captureAnyNamed('headers')
      )).thenAnswer((_) async => wrongCredentialsResponse);
    });

    test('Should be able to send valid login request.', () async {
      await api.attemptLogin('morten', 'password');

      var verifier = verify(mock.post(
          'test.test/User/Authenticate',
          body: captureAnyNamed('body'),
          encoding: captureAnyNamed('encoding'),
          headers: captureAnyNamed('headers')
      ));

      verifier.called(1);

      var captured = verifier.captured;

      expect(captured[0], '{"username": "morten","password": "password"}');
      expect(captured[1], isNull);
      expect(captured[2], {HttpHeaders.contentTypeHeader: 'application/json'});
    });

    test('Should return the response as a Map key=>value', () async {
      var response = await api.attemptLogin('morten', 'password');

      expect(response['id'], 1);
      expect(response['username'], 'morten');
      expect(response['firstName'], 'Morten');
      expect(response['lastName'], 'Petersen');
      expect(response['token'], 'fake-token');
    });

    test('Should throw an exception if cannot login', () async {
      expectException(
          () async => await api.attemptLogin('morten', 'wrong-password'),
          'Login operation failed, please ensure credentials are correct!'
      );
    });
  });

  group('Get Screens API test', () {
    setUp(() {
      when(mock.get(
          'test.test/App/GetScreens/1',
          headers: {HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer valid-token'}
      )).thenAnswer((_) async => http.Response('[{"status": "OK"}, {"status": "OK"}]', 200));

      when(mock.get(
          'test.test/App/GetScreens/2',
          headers: {HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer valid-token'}
      )).thenAnswer((_) async => http.Response('[{"id": 6,"screenName": "test","screenContent": "[{\\\"type\\\": \\\"Text\\\", \\\"name\\\": \\\"test\\\", \\\"data\\\": \\\"Login\\\", \\\"position\\\": 0}]"}]', 200));

      when(mock.get(
          'test.test/App/GetScreens/999',
          headers: {HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer valid-token'}
      )).thenAnswer((_) async => http.Response('[]', 200));

      when(mock.get(
          'test.test/App/GetScreens/1',
          headers: {HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer invalid-token'}
      )).thenAnswer((_) async => http.Response('Bad Request', 400));
    });

    test('Should be able to send valid getScreens request', () async {
      await api.getScreens(1, 'valid-token');

      var verifier = verify(mock.get(
          'test.test/App/GetScreens/1',
          headers: captureAnyNamed('headers')
      ));

      verifier.called(1);

      var captured = verifier.captured;

      expect(captured[0], {HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer valid-token'});
    });

    test('Should throw an error if no screens available or id is not correct', () async {
      expectException(
              () async => await api.getScreens(999, 'valid-token'),
          'Was not able to fetch screens, either none exists yet or the id of the app is not correct.'
      );
    });

    test('Should throw an error if invalid token is used', () async {
      expectException(
              () async => await api.getScreens(1, 'invalid-token'),
          'Was not able to fetch screens, either the token is invalid or the service is down.'
      );
    });

    test('Should be able to parse response from server correctly', () async {
      final response = await api.getScreens(2, 'valid-token');
      final item = response.first;

      expect(item['id'], 6);
      expect(item['screenName'], 'test');
      expect(item['screenContent'] is List, isTrue);
      expect(item['screenContent'].length, 1);

      final el = item['screenContent'].first;

      expect(el['type'], 'Text');
      expect(el['name'], 'test');
      expect(el['data'], 'Login');
      expect(el['position'], 0);
    });
  });
}