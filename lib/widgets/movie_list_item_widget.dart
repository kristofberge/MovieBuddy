import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_buddy/pages/home_page.dart';
import 'package:movie_buddy/util/constants.dart';

class MovieListItemWidget extends StatelessWidget {
  const MovieListItemWidget(this.item);

  final MovieListItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: FadeInImage(
              image: NetworkImage(item.poster),
              placeholder: AssetImage(Images.moviePlaceholder),
              height: 180,
              fit: BoxFit.fitHeight,
            ),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    item.name,
                    style: TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          item.genre,
                          style: TextStyle(color: Colors.grey),
                          overflow: TextOverflow.fade,
                          maxLines: 2,
                        ),
                      ),
                      Flexible(
                          child:
                              Text(DateFormat.yMMMd().format(item.releaseDate), style: TextStyle(color: Colors.grey)))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
