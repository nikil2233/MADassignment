class Vet {
  final String id;
  final String name;
  final String clinicName;
  final String specialty;
  final double rating;
  final double distance;
  final String imageUrl;
  final int reviews;

  final List<String> acceptedAnimals;

  final String? profileBase64;
  final String? about;
  final String? clinicGoal;
  final String? address;
  final String? city;

  Vet({
    required this.id,
    required this.name,
    required this.clinicName,
    required this.specialty,
    required this.rating,
    required this.distance,
    required this.imageUrl,
    this.profileBase64,
    required this.acceptedAnimals,
    required this.reviews,
    this.about,
    this.clinicGoal,
    this.address,
    this.city,
  });
}

final List<Vet> mockVets = [
  Vet(
    id: '1',
    name: 'Dr. Sarah Wilson',
    clinicName: 'Happy Paws Clinic',
    specialty: 'General Practitioner',
    rating: 4.8,
    distance: 1.2,
    imageUrl:
        'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    acceptedAnimals: ['Dog', 'Cat', 'Rabbit'],
    reviews: 120,
  ),
  Vet(
    id: '2',
    name: 'Dr. James Rodriguez',
    clinicName: 'Pet Care Center',
    specialty: 'Surgeon',
    rating: 4.9,
    distance: 2.5,
    imageUrl:
        'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    acceptedAnimals: ['Dog', 'Cat', 'Reptile', 'Birds'],
    reviews: 85,
  ),
  Vet(
    id: '3',
    name: 'Dr. Emily Chen',
    clinicName: 'City Vet Hospital',
    specialty: 'Dermatologist',
    rating: 4.7,
    distance: 3.8,
    imageUrl:
        'https://images.unsplash.com/photo-1594824476967-48c8b964273f?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    acceptedAnimals: ['Cat', 'Hamster'],
    reviews: 45,
  ),
];
