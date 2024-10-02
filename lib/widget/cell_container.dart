import 'package:flutter/material.dart';

IntrinsicWidth cellContainer(String text) {
  return IntrinsicWidth(
    child: SizedBox(
      width: 200,
      height: 100,
      child: Text(text, overflow: TextOverflow.ellipsis, maxLines: 3,),
    ),
  );
}
