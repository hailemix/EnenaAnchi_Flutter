import 'package:enena_anchi/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  final homePage = MyHomePageState();
  bool tapped = homePage.isTapped;
  String contents = homePage.finalContent;

  test("Tapping Test", (){
    expect(tapped, false);
  });

  test("Contents Test", (){
    expect(contents, '');
  });
  test("Final Content Loading Checkup",(){
    expect(homePage.finalContent, '');
  });
  test("Tap Animation",(){
    expect(homePage.animationIsCompleted, false);

  });

}
