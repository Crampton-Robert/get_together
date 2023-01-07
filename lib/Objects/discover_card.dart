import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:get_together/pages/Discover/make_or_edit_events.dart';
import 'package:get_together/pages/Profile Page/profile_class_groups_and_events.dart';

class DiscoverCard extends StatefulWidget {
  final child;

  DiscoverCard({Key? key, required this.child}) : super(key: key);
  @override
  State<DiscoverCard> createState() => _DiscoverCardState();
}

class _DiscoverCardState extends State<DiscoverCard> {


  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: widget.child
    );

  }
}