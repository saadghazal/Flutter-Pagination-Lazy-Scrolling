part of 'posts_bloc.dart';

enum FirstLoadStatus { initial, loading, loaded, error }

enum LoadMoreStatus {
  initial,
  loading,
  loaded,
  noMore,
  error,
}

class PostsState extends Equatable {
  final FirstLoadStatus firstLoadStatus;
  final LoadMoreStatus loadMoreStatus;
  final int pageNumber;
  final List<Post> postsList;
  final ErrorHandler errorHandler;

  const PostsState({
    required this.firstLoadStatus,
    required this.loadMoreStatus,
    required this.postsList,
    required this.errorHandler,
    required this.pageNumber,
  });

  factory PostsState.initial() {
    return const PostsState(
      firstLoadStatus: FirstLoadStatus.initial,
      loadMoreStatus: LoadMoreStatus.initial,
      postsList: [],
      errorHandler: ErrorHandler(errorMessage: ''),
      pageNumber: 1,
    );
  }

  @override
  String toString() {
    return 'PostsState{firstLoadStatus: $firstLoadStatus, loadMoreStatus: $loadMoreStatus, postsList: $postsList}';
  }

  @override
  List<Object> get props => [
        firstLoadStatus,
        loadMoreStatus,
        postsList,
        errorHandler,
    pageNumber,
      ];

  PostsState copyWith({
    FirstLoadStatus? firstLoadStatus,
    LoadMoreStatus? loadMoreStatus,
    int? pageNumber,
    List<Post>? postsList,
    ErrorHandler? errorHandler,
  }) {
    return PostsState(
      firstLoadStatus: firstLoadStatus ?? this.firstLoadStatus,
      loadMoreStatus: loadMoreStatus ?? this.loadMoreStatus,
      pageNumber: pageNumber ?? this.pageNumber,
      postsList: postsList ?? this.postsList,
      errorHandler: errorHandler ?? this.errorHandler,
    );
  }
}
