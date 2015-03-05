#include <stdio.h>
#include <string.h>

#define MAX_F_LEN 256

int main(int argc, char *argv[])
{
  if (argc!=2) {
    printf("Usage: gorak {output code}\n");
    return 1;
  }

  if (strlen(argv[1])>MAX_F_LEN)
  {
    printf("{output code} cannot be longer than %d\n",MAX_F_LEN);
    return 2;
  }

  char oName[MAX_F_LEN];
  char iCode[MAX_F_LEN];
  char oComp[MAX_F_LEN];

  printf("Input text:");
  fgets(iCode, 32, stdin);
  if (strlen(iCode)<2) {
    printf("Input text must be entered\n");
    return 3;
  }

  strtok(iCode, "\n");

  sprintf(oName,"%s.c",argv[1]);
  
  FILE *oFile = fopen(oName,"w");
  fprintf(oFile, "#include <stdio.h>\n");
  fprintf(oFile, "void main()\n");
  fprintf(oFile, "{\n");
  fprintf(oFile, "  printf(\"%s\");\n",iCode);
  fprintf(oFile, "}\n");
  fclose(oFile);

  sprintf(oComp,"cc -o %s %s",argv[1],oName);
  int cRet=system(oComp);

  if (cRet) {
    printf("Error making output: %d\n",cRet);
  } else {
    printf("All good\n");
  }  

  remove(oName); 
}
