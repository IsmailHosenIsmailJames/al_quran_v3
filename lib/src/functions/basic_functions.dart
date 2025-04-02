String capitalizeFirstLatter(String input) {
  if (input.isEmpty) {
    return '';
  }
  return input[0].toUpperCase() + input.substring(1);
}
