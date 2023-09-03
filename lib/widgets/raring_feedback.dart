import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarRatingWidget extends StatefulWidget {
  final double initialRating;
  final ValueChanged<double> onRatingChanged;

  StarRatingWidget({
    required this.initialRating,
    required this.onRatingChanged,
  });

  @override
  _StarRatingWidgetState createState() => _StarRatingWidgetState();
}

class _StarRatingWidgetState extends State<StarRatingWidget> {
  double _rating = 0;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: _rating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 24.0,
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (newRating) {
        setState(() {
          _rating = newRating;
        });
        widget.onRatingChanged(newRating);
      },
    );
  }
}
