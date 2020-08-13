#include    <stdio.h>
#include    <string.h>
#include    <sysexits.h>

int
main (int argc, char *argv[])
{
    char combined[50]   = "";

    strcat (combined, argv[1]);
    strcat (combined, " ");
    strcat (combined, argv[2]);

    printf ("The two arguments combines is: %s\n", combined);

    return EX_OK;
}
