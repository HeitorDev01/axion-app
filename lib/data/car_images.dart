/// Catálogo das fotos dos carros.
///
/// Cada modelo tem a sua própria foto dentro de `assets/cars/`, então nenhum
/// card da lista repete a mesma imagem. A busca é feita por palavra-chave do
/// modelo: assim os carros que vêm do Firebase (que podem não ter o campo
/// `image` salvo) também recebem a foto certa a partir do nome.
library;

/// Foto usada quando o modelo não bate com nenhuma palavra-chave conhecida.
const String kDefaultCarImage = 'assets/cars/porsche_911.jpg';

/// A ordem importa: as chaves mais específicas (modelo) vêm antes das
/// genéricas (marca), senão um "Porsche Macan" cairia na foto do 911.
const Map<String, String> kCarImages = {
  'huracan': 'assets/cars/lamborghini_huracan.jpg',
  'huracán': 'assets/cars/lamborghini_huracan.jpg',
  'macan': 'assets/cars/porsche_macan.jpg',
  '911': 'assets/cars/porsche_911.jpg',
  'g-class': 'assets/cars/mercedes_gclass.jpg',
  'classe g': 'assets/cars/mercedes_gclass.jpg',
  'amg g': 'assets/cars/mercedes_gclass.jpg',
  'm4': 'assets/cars/bmw_m4.jpg',
  'r8': 'assets/cars/audi_r8.jpg',
  'range rover': 'assets/cars/range_rover_sport.jpg',
  'raptor': 'assets/cars/ford_ranger_raptor.jpg',
  'ranger': 'assets/cars/ford_ranger_raptor.jpg',
  'fortuner': 'assets/cars/toyota_fortuner.jpg',
  'model s': 'assets/cars/tesla_model_s.jpg',
  // Marcas — só entram se nenhum modelo acima bater.
  'lamborghini': 'assets/cars/lamborghini_huracan.jpg',
  'mercedes': 'assets/cars/mercedes_gclass.jpg',
  'bmw': 'assets/cars/bmw_m4.jpg',
  'audi': 'assets/cars/audi_r8.jpg',
  'land rover': 'assets/cars/range_rover_sport.jpg',
  'ford': 'assets/cars/ford_ranger_raptor.jpg',
  'toyota': 'assets/cars/toyota_fortuner.jpg',
  'tesla': 'assets/cars/tesla_model_s.jpg',
  'porsche': 'assets/cars/porsche_911.jpg',
};

/// Devolve a foto do modelo informado (ex.: 'Fortuner GR' → Toyota Fortuner).
String carImageFor(String model) {
  final name = model.toLowerCase();
  for (final entry in kCarImages.entries) {
    if (name.contains(entry.key)) return entry.value;
  }
  return kDefaultCarImage;
}
