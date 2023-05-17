part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();
}

class FirstLoadEvent extends PostsEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadMoreEvent extends PostsEvent {


  @override
  List<Object> get props => [];
}