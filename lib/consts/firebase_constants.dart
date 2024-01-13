import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

//Collections

const LikesCollection = "Likes";
const socialPostsCollection = "Social Posts";
const commentsCollection = "comments";
const coursesCollection = "courses";
const eventsCollection = "events";
const bookedEventsCollection = "bookedEvents";
const moodDataCollection = 'moodData';
const usersCollection = "users";
