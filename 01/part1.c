#import <stdio.h>

int main() {
  int frequency = 0, frequencyChange;

  FILE *f = fopen("input1.txt", "r");
  while (1 == fscanf(f, "%d\n", &frequencyChange)) {
    frequency += frequencyChange;
  }
  fclose(f);

  printf("%d\n", frequency);

  return 0;
}
