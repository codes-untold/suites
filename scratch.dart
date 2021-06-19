

void main() {

   String a = 12345.toString();


String fixPrice(String price){
  switch (price.length) {
    case 5:
      return "${price.substring(0, 2)},${price.substring(2, 5)}";

      break;
    case 6:
      return "${price.substring(0, 3)},${price.substring(3, 6)}";

      break;
    case 7:
     return "${price.substring(0,1)},${price.substring(1, 4)},${price.substring(4, 7)}";

  }


}


  print(fixPrice(a));

}