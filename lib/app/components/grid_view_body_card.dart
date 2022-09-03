import 'package:flutter/material.dart';

class GridViewBodyCard extends StatelessWidget {
  const GridViewBodyCard(
      {Key? key, required this.title, required this.imageUrl})
      : super(key: key);
  final String imageUrl;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(14, 19, 49, 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: GridTile(
        footer: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          color: Colors.black45,
          alignment: Alignment.bottomCenter,
          child: Text(
            title,
            style: const TextStyle(
              height: 1.3,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            textAlign: TextAlign.center,
          ),
        ),
        child: Container(
          color: const Color.fromRGBO(14, 19, 49, 1),
          child: imageUrl.isNotEmpty
              ?
              //عقبال مالصورة تيجى يعرض الlooding
              FadeInImage.assetNetwork(
                  placeholder: 'images/loading.gif',
                  image: imageUrl,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) =>
                      Image.asset('images/failLoading/image_fail_loading.jpeg'))
              : Image.asset('images/failLoading/image_fail_loading.jpeg'),
        ),
      ),
    );
  }
}
