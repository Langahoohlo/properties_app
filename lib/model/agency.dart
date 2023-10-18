// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';

class Agency {
  final String agencyName;
  final String agencyEmail;
  final String agencyPhoneNumbers;
  final String agencyPhotoUrl;
  final String agencyUid;
  final String agencyBio;
  final List agentsList;
  final bool isVerified;

  const Agency({
    required this.agencyBio,
    required this.agencyName,
    required this.agencyEmail,
    required this.agencyPhoneNumbers,
    required this.agencyPhotoUrl,
    required this.agencyUid,
    required this.agentsList,
    required this.isVerified,
  });

  Map<String, dynamic> toJson() => {
        "agencyName": agencyName,
        "email": agencyEmail,
        "phoneNumbers": agencyPhoneNumbers,
        "photoUrl": agencyPhotoUrl,
        "uid": agencyUid,
        "agentsList": agentsList,
        "isVerified": isVerified,
      };

  static Agency fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Agency(
        agencyName: snapshot['agencyName'],
        agencyEmail: snapshot['agencyEmail'],
        agencyPhoneNumbers: snapshot['agencyPhoneNumbers'],
        agencyPhotoUrl: snapshot['photoUrl'],
        agencyUid: snapshot['uid'],
        agentsList: snapshot['agentsList'],
        isVerified: snapshot['isVerified'],
        agencyBio: snapshot['agencyBio']);
  }
}
