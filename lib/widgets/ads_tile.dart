import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:bet_seed/backends/all_repos.dart';
import 'package:bet_seed/models/ads_model.dart';
import 'package:bet_seed/utils/colors.dart';

class AdsTile extends StatefulWidget {
  const AdsTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  _AdsTileState createState() => _AdsTileState();
}

class _AdsTileState extends State<AdsTile> {
  AllRepos _allRepos = AllRepos();

  @override
  Widget build(BuildContext context) {
    var _ads = AdsModel.fromJson(widget.data);

    return ListTile(
      leading: Container(
        width: 60,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(_ads.adsImage),
          ),
        ),
      ),
      title: Text(_ads.adsTitle),
      subtitle: Text(
        _ads.adsDescription,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Container(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () => _deletePopUp(_ads),
              icon: Icon(
                IconlyLight.delete,
                color: red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _deletePopUp(AdsModel _ads) {
    _allRepos
        .showPopUp(context, Text("Are you sure you want to delete advert?"), [
      CupertinoButton(
        child: Text("Delete"),
        onPressed: () => _deleteAdsFxn(_ads),
      ),
      CupertinoButton(
        child: Text("Cancel"),
        onPressed: () => Navigator.pop(context),
      ),
    ], [
      TextButton(
        child: Text("Delete"),
        onPressed: () => _deleteAdsFxn(_ads),
      ),
      TextButton(
        child: Text("Cancel"),
        onPressed: () => Navigator.pop(context),
      ),
    ]);
  }

  _deleteAdsFxn(AdsModel _ads) async {
    Map data = {
      'adsImage': _ads.adsImage,
      'adsId': _ads.adsId,
    };
    try {
      await _allRepos.deleteAds(data, context);
      await _ads.refreshFxn!();
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }
}
