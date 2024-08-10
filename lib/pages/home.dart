import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_task9/pages/comments_page.dart';
import 'package:provider_task9/providers/posts_provider.dart';
import 'package:provider_task9/widegts/my_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Posts',
      ),
      body: Consumer<PostsProvider>(
        builder: (context, postsProvider, child) {
          if (postsProvider.isLoadingPosts) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return showPosts(postsProvider, context);
          }
        },
      ),
    );
  }

  Widget showPosts(PostsProvider postsProvider, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          ...postsProvider.posts.map((e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    title: Text(e['title'],
                        style: const TextStyle(fontWeight: FontWeight.w700)),
                    subtitle: Text(e['body'] ?? ''),
                    leading: CircleAvatar(
                      child: Center(
                        child: Text('P${e['id'].toString()}'),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CommentsPage(postId: e['id'])));
                    },
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
