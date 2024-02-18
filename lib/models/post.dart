
import 'package:flutter/material.dart';

class Post {
  final String post;
  final String poster;
  final Image image;

  Post({required this.post, required this.poster, required this.image});
}


// create a list of doctors to display in the ListView
final List<Post> posts = [
  Post(
    post: 'Post 1',
    poster: 'Poster 1',
    image: Image.network('https://cdn.pixabay.com/photo/2016/11/14/05/21/children-1822688_1280.jpg',height: 80, width: 50, fit: BoxFit.fill),
  ),
  Post(
    post: 'Post 2',
    poster: 'Poster 2',
    image: Image.network('https://cdn.pixabay.com/photo/2014/02/13/07/28/security-265130_1280.jpg', height: 80, width: 50, fit: BoxFit.fill),
  ),
  Post(
    post: 'Post 3',
    poster: 'Poster 3',
    image: Image.network('https://cdn.pixabay.com/photo/2016/05/13/17/16/letter-1390463_1280.jpg', height: 80, width: 50, fit: BoxFit.fill),
  ),
  Post(
    post: 'Post 4',
    poster: 'Poster 4',
    image: Image.network('https://cdn.pixabay.com/photo/2015/01/01/23/55/telephone-586266_1280.jpg',height: 80, width: 50, fit: BoxFit.fill),
  ),
];