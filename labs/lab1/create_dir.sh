#!/bin/bash

mkdir lab1
cd lab1
touch hello_world.c
echo '#include <stdio.h>

int main(int argc, char **argv) {
    (void)argc;
    (void)argv;
    printf("Hello, World!\n");
    return (0);
}' > hello_world.c
