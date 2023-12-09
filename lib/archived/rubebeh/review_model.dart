
class ReviewModel {
  final String userId; // ID of the user who wrote the review
  final String userName; // Name of the user who wrote the review
  final String comment;
  final double rating;

  ReviewModel({
    required this.userId,
    required this.userName,
    required this.comment,
    required this.rating,
  });
}