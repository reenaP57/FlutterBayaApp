import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:social_share/social_share.dart';

Future<void> makePhoneCall(String contactNo) async {
  var url = 'tel:$contactNo';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not lunch $url';
  }
}

shareOnSocial(String content, {String imagePath}) {
  SocialShare.shareOptions(content, imagePath: imagePath);
}