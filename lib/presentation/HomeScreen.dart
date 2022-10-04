import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination/cubit/app_cubit.dart';
import 'package:pagination/cubit/app_states.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController scrollController /*= ScrollController()*/;

  @override
  void initState() {
    scrollController = ScrollController()
      ..addListener(() {
        if(scrollController.position.atEdge){
          if(scrollController.position.pixels == 0){
            print('top');
          }else{
            print('bot');
            AppCubit.get(context).loadMoreData();
          }
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Pagination'),
          ),
          body: state is AppGetDataLoadingState
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    MaterialButton(
                      onPressed: () {
                        print(AppCubit.get(context)
                            .passengers
                            .first
                            .airLine
                            .length);
                      },
                      child: Text('Test'),
                    ),
                    Expanded(
                        child: ListView.separated(
                          controller: scrollController,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  '${AppCubit.get(context).passengers[index].name}',
                                ),
                                subtitle: Text(
                                    "${AppCubit.get(context).passengers[index].airLine.first.country}"),
                                trailing: Text(
                                    '${AppCubit.get(context).passengers[index].airLine.first.name}'),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 10.0,
                              );
                            },
                            itemCount: AppCubit.get(context).passengers.length)),
                    state is AppLoadMoreDataLoadingState ? const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 40),
                      child: Center(child: CircularProgressIndicator()),
                    ) : Container()
                  ],
                ),
        );
      },
    );
  }
}
