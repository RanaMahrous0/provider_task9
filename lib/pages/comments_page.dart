import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_task9/providers/post_details_provider.dart';
import 'package:provider_task9/widegts/myTitle.dart';
import 'package:provider_task9/widegts/my_app_bar.dart';

class CommentsPage extends StatefulWidget {
  final int postId;
  const CommentsPage({required this.postId, super.key});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  @override
  Widget build(BuildContext context) {
    final postDetailsProvider =
        Provider.of<PostDetailsProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      postDetailsProvider.fetchComments(widget.postId);
      postDetailsProvider.fetchPost(widget.postId);
    });
    return Scaffold(
      appBar: MyAppBar(title: 'Post ${widget.postId} Details'),
      body: Consumer<PostDetailsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoadingComments || provider.isLoadingPost) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return showCommentsWidget(provider);
          }
        },
      ),
    );
  }

  Widget showCommentsWidget(PostDetailsProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MyTitleWidget(title: 'Post'),
          Card(
            child: ListTile(
              title: Text(
                provider.post['title'] ?? '',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text(provider.post['body'] ?? ''),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const MyTitleWidget(title: 'Comments'),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: provider.comments.length,
                  itemBuilder: (context, index) {
                    final comment = provider.comments[index];
                    return Card(
                        child: ListTile(
                      title: Text(
                        comment['name'],
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(comment['body']),
                      leading: const CircleAvatar(
                        child: Center(
                          child: Icon(Icons.person),
                        ),
                      ),
                    ));
                  }))
        ],
      ),
    );
  }
}
