import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pagination/blox/posts_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController pagingController;

  @override
  void initState() {
    super.initState();
    pagingController = ScrollController()
      ..addListener(() {
        if (pagingController.position.maxScrollExtent ==
            pagingController.offset) {
          context.read<PostsBloc>().add(LoadMoreEvent());
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagination (Lazy Scrolling)'),
        centerTitle: true,
      ),
      body: BlocConsumer<PostsBloc, PostsState>(
        listener: (context, state) {
          if (state.firstLoadStatus == FirstLoadStatus.error) {
            showDialog(
              context: context,
              builder: (context) =>const AlertDialog(
                content: Text('Error Occurred'),
              ),
            );
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              state.firstLoadStatus == FirstLoadStatus.loading
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        controller: pagingController,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            margin: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Text(state.postsList[index].title),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(state.postsList[index].body),
                              ],
                            ),
                          );
                        },
                        itemCount: state.postsList.length,
                      ),
                    ),
              Visibility(
                visible: state.loadMoreStatus == LoadMoreStatus.loading,
                replacement: state.loadMoreStatus == LoadMoreStatus.noMore
                    ? SafeArea(child: Text('No More Data'))
                    : state.loadMoreStatus == LoadMoreStatus.error
                        ? SafeArea(child: Text('Error Occurred'))
                        : SizedBox(),
                child: const SafeArea(
                  child: SizedBox(
                    height: 50,
                    width: double.maxFinite,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
