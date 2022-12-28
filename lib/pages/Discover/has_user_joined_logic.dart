Widget build(BuildContext context) {
  return new StreamBuilder(
      stream: Firestore.instance.collection('COLLECTION_NAME').document('TESTID1').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return new Text("Loading");
        }
        var userDocument = snapshot.data;
        return new Text(userDocument["name"]);
      }
  );
}


print('ufbcu');