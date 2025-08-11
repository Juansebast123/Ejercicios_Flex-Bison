#include <stdio.h>
#include <ctype.h>

int main(int argc, char **argv) {
    FILE *fp;
    int chars = 0, words = 0, lines = 0;
    int in_word = 0;
    int c;

    if (argc < 2) {
        fprintf(stderr, "Uso: %s archivo...\n", argv[0]);
        return 1;
    }

    for (int i = 1; i < argc; i++) {
        fp = fopen(argv[i], "r");
        if (!fp) {
            perror(argv[i]);
            continue;
        }

        while ((c = fgetc(fp)) != EOF) {
            chars++;

            if (c == '\n')
                lines++;

            if (isalpha(c)) {
                if (!in_word) {
                    words++;
                    in_word = 1;
                }
            } else {
                in_word = 0;
            }
        }

        fclose(fp);
    }

    printf("%8d%8d%8d\n", lines, words, chars);
    return 0;
}

