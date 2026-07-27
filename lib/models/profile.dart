import 'package:flutter/material.dart';

class Profile {
    final String name;
    final Color color;

    const Profile({
        required this.name,
        required this.color,
    });
}

const   goetz = Profile(
    name: "Götz",
    color: Colors.green,
);

const christin  = Profile(
    name: "Christin",
    color: Colors.black,
);