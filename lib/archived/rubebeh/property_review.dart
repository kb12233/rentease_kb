import 'package:flutter/material.dart';
import 'package:rentease_kb/archived/rubebeh/review_model.dart';

class PropertyReviewWidget extends StatelessWidget {
  final ReviewModel review;

  PropertyReviewWidget({required this.review});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(review.userName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Rating: ${review.rating}'),
          Text(review.comment),
        ],
      ),
    );
  }
}

class PropertyReviewsList extends StatelessWidget {
  final List<ReviewModel> reviews;

  PropertyReviewsList({required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reviews',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        if (reviews.isNotEmpty)
          Column(
            children: reviews.map((review) => PropertyReviewWidget(review: review)).toList(),
          ),
        if (reviews.isEmpty) Text('No reviews available.'),
      ],
    );
  }
}
