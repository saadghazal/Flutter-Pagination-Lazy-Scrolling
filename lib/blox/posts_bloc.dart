import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pagination/erro_handler.dart';

import '../models/post.dart';
import '../repository/place_holder_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PlaceHolderRepository placeHolderRepository;
  PostsBloc({required this.placeHolderRepository})
      : super(PostsState.initial()) {
    on<PostsEvent>(
      (event, emit) async {
        if (event is FirstLoadEvent) {
          emit(state.copyWith(firstLoadStatus: FirstLoadStatus.loading));
          try {
            final posts = await placeHolderRepository.firstLoad();
            emit(
              state.copyWith(
                firstLoadStatus: FirstLoadStatus.loaded,
                postsList: posts,
              ),
            );
          } on ErrorHandler catch (e) {
            emit(
              state.copyWith(
                firstLoadStatus: FirstLoadStatus.error,
                errorHandler: e,
              ),
            );
          }
        } else if (event is LoadMoreEvent) {
          emit(
            state.copyWith(
              loadMoreStatus: LoadMoreStatus.loading,
            ),
          );
          try {
            final count=state.pageNumber+1;
            if (kDebugMode) {
              print('Page Count = $count');
            }
            final morePosts =
                await placeHolderRepository.loadMore(count);
            if (morePosts.isEmpty) {
              emit(
                state.copyWith(
                  loadMoreStatus: LoadMoreStatus.noMore,
                  pageNumber: count,
                ),
              );
            } else {
              List<Post> newPosts = state.postsList;
              newPosts.addAll(morePosts);
              emit(
                state.copyWith(
                  loadMoreStatus: LoadMoreStatus.loaded,
                  pageNumber: count,
                ),
              );
            }
          } on ErrorHandler catch (e) {
            emit(
              state.copyWith(
                loadMoreStatus: LoadMoreStatus.error,
                errorHandler: e,
              ),
            );
          }
        }
      },
    );
  }
}
