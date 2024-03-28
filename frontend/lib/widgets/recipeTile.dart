import 'package:flutter/material.dart';
import '../models/recipe.dart';
import 'customText.dart';

class RecipeTile extends StatefulWidget {
  final Recipe recipe;

  RecipeTile({required this.recipe});

  @override
  _RecipeTileState createState() => _RecipeTileState();
}

class _RecipeTileState extends State<RecipeTile> {
  bool isExpanded = false;
  bool isStarred = false;

  List<Widget> _buildBulletedList(String text) {
    List<String> lines = text.split('. ');

    return lines.map((line) {
      if (line.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '-',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  line.trim(),
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        );
      } else {
        return Container(); // Skip empty lines
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: ListTile(
          contentPadding: EdgeInsets.all(5),
          leading: Image.network(
              widget.recipe.image),
          title: Center(child: Text(widget.recipe.title)),
        ),
        trailing: IconButton(
          icon: Icon(
            isStarred ? Icons.star : Icons.star_border,
            color: Colors.amber, // Gold star color
          ),
          onPressed: () {
            setState(() {
              isStarred = !isStarred;
            });
            var snackBar = SnackBar(
              behavior: SnackBarBehavior.floating,
              width: MediaQuery.of(context).size.width * 0.8,
              duration: const Duration(seconds: 2),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              content: CustomText(text: "Recipe Saved", color: Colors.white, space:1, size: 18),
              backgroundColor: Colors.green,
            );
            if (isStarred)
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

          },
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildBulletedList(widget.recipe.description),
            ),
          ),
        ],
      ),
    );
  }
}