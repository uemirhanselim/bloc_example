import 'package:bloc_example/constants/enums.dart';
import 'package:bloc_example/logic/cubit/counter_cubit.dart';
import 'package:bloc_example/logic/cubit/internet_cubit.dart';
import 'package:bloc_example/presentation/screens/second_screen.dart';
import 'package:bloc_example/presentation/screens/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title, required this.color})
      : super(key: key);
  final String title;
  final Color color;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnected &&
            state.connectionType == ConnectionType.Wifi) {
          BlocProvider.of<CounterCubit>(context).increment();
        } else if (state is InternetConnected &&
            state.connectionType == ConnectionType.Mobile) {
          BlocProvider.of<CounterCubit>(context).decrement();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.color,
          title: Text(widget.title),
          actions: [
          IconButton(
              icon: Icon(Icons.settings,color: Colors.red,),
              onPressed: () => Navigator.pushNamed(context, '/settings')),
        ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<InternetCubit, InternetState>(
                builder: (context, state) {
                  if (state is InternetConnected &&
                      state.connectionType == ConnectionType.Wifi) {
                    return Text("Wifi");
                  } else if (state is InternetConnected &&
                      state.connectionType == ConnectionType.Mobile) {
                    return Text("Mobile");
                  } else if (state is InternetDisconnected) {
                    return Text("Disconnected");
                  }
                  return CircularProgressIndicator();
                },
              ),
              Text("You have pushed the button this many times:"),
              BlocConsumer<CounterCubit, CounterState>(
                listener: (context, state) {
                  if (state.wasIncremented == true) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Incremented!"),
                      duration: Duration(milliseconds: 300),
                    ));
                  } else if (state.wasIncremented == false) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Decremented!"),
                      duration: Duration(milliseconds: 300),
                    ));
                  }
                },
                builder: (context, state) {
                  return Text(
                    state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              Builder(
                builder: (context) {
                  final counterState = context.watch<CounterCubit>().state;
                  final internetState = context.watch<InternetCubit>().state;

                  if (internetState is InternetConnected &&
                      internetState.connectionType == ConnectionType.Mobile) {
                    return Text(
                      "Counter: " +
                          counterState.counterValue.toString() +
                          "Internet: Mobile",
                      style: Theme.of(context).textTheme.headline6,
                    );
                  } else if (internetState is InternetConnected && internetState.connectionType == ConnectionType.Wifi) {
                    return Text("Counter: " + counterState.counterValue.toString() + "Internet: Wi-fi");
                  } else {
                    return Text("Counter: " + counterState.counterValue.toString() + "Internet: Disconnected");
                  }
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              Builder(
                builder: (context) {
                  final counterValue = context.select((CounterCubit cubit) => cubit.state.counterValue);
                  return Text("Counter: " + counterValue.toString(), style: Theme.of(context).textTheme.headline6,);
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              Row(
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      context.read<CounterCubit>().decrement();
                    },
                    tooltip: "Decrement",
                    child: Icon(Icons.remove),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      context.read<CounterCubit>().increment();
                    },
                    tooltip: "Increment",
                    child: Icon(Icons.add),
                  ),
                ],
              ),
              SizedBox(
                height: 24.0,
              ),
              MaterialButton(
                color: widget.color,
                child: Text("Go to Second Screen"),
                onPressed: () {
                  Navigator.of(context).pushNamed("/second");
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              MaterialButton(
                color: widget.color,
                child: Text("Go to Third Screen"),
                onPressed: () {
                  Navigator.of(context).pushNamed("/third");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
