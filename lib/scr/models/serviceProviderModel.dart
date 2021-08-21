class ServiceProviderModel {
  final String serviceProviderId;
  final String serviceProviderEmail;
  final String address;
  final String serviceProviderName;
  final String city;
  final String country;
  final String about;
  final String serviceProviderProfilePic;
  final List skills;

  ServiceProviderModel(
      {this.serviceProviderId,
      this.about,
      this.address,
      this.city,
      this.country,
      this.serviceProviderEmail,
      this.serviceProviderName,
      this.serviceProviderProfilePic,
      this.skills});

  Map<String, dynamic> toMap() {
    return {
      'userId': serviceProviderId,
      'serviceProviderEmail': serviceProviderEmail,
      'address': address,
      'serviceProviderName': serviceProviderName,
      'city': city,
      'country': country,
      'about': about,
      "serviceProviderProfilePic": serviceProviderProfilePic,
      "skill": [
        skills
      ]
      
    };
  }

  ServiceProviderModel.fromFirestore(Map<String, dynamic> firestore)
      : serviceProviderId = firestore['serviceProviderId'],
        serviceProviderEmail = firestore['serviceProviderEmail'],
        address = firestore['address'],
        serviceProviderName = firestore['serviceProviderName'],
        city = firestore['city'],
        country = firestore['country'],
        about = firestore['about'],
        serviceProviderProfilePic = firestore['serviceProviderProfilePic'],
        skills = firestore["skill"]
        ;
}
