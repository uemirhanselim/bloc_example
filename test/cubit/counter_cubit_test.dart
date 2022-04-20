import 'package:bloc_example/cubit/counter_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("CounterCubit", (){
    CounterCubit? counterCubit;
  
    setUp((){
      counterCubit = CounterCubit();
    });

    tearDown((){
      counterCubit!.close();
    });

    test("the initial state for the CounterCubit is CounterState(counterValue:0)", (){
      expect(counterCubit!.state, CounterState(counterValue: 0));
    });

  });
}