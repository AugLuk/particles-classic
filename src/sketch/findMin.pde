int findMin(float[] arr) {
  int idx = 0;
  float maxVal = arr[0];
  for (int i = 1; i < arr.length; i++) {
    if (maxVal > arr[i]) {
      idx = i;
      maxVal = arr[i];
    }
  }
  return idx;
}
