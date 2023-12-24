import 'package:flutter/material.dart';
import 'package:spikeguard/screens/OwnerInfoScreen.dart';

class CompanyInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Explore',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              
              // Show sliding panel with owner information
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return OwnerInfoScreen();
                },
              );
            },
          ),
        ],
      ),
      body: InstagramPostList(),
    );
  }
}

class InstagramPostList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace the following with actual data fetching logic
    List<Post> posts = getPosts();

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return InstagramPostCard(post: posts[index]);
      },
    );
  }
}

class InstagramPostCard extends StatelessWidget {
  final Post post;

  InstagramPostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(12.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
            child: Image.asset(
              post.imageUrl,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${post.caption}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                // Display comments here
                // ...
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Post {
  final String imageUrl;
  final String caption;

  Post({
    required this.imageUrl,
    required this.caption,
  });
}

List<Post> getPosts() {
  return [
    Post(
      imageUrl: 'assets/add/1.jpg',
      caption:
          'This is the caption for post 1. It can be a bit longer to see how the text wraps.',
    ),
    Post(
      imageUrl: 'assets/product/stabilizer.png',
      caption: 'This is the caption for post 2.',
    ),
    Post(
      imageUrl: 'assets/product/stabilizer.png',
      caption: 'This is the caption for post 3.',
    ),
    Post(
      imageUrl: 'assets/product/stabilizer.png',
      caption: 'This is the caption for post 4.',
    ),
  ];
}


