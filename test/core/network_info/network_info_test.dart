import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app_tdd/core/network_info/network_info.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late MockInternetConnectionChecker internetConnectionChecker;
  late NetworkInfoImpl networkInfo;

  setUp(() {
    internetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(internetConnectionChecker);
  });

  final testConnectionValue = Future.value(true);

  test(
      'should call the internetConnectionChecker().hasConnection when call the getCurrentConnectionState',
      () async {
    when(internetConnectionChecker.hasConnection)
        .thenAnswer((realInvocation) => testConnectionValue);
    final result = networkInfo.getCurrentConnectionState;
    expect(result, testConnectionValue);
    verify(internetConnectionChecker.hasConnection);
  });
}
