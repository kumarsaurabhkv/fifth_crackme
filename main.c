#include <stdio.h>
#include <stdlib.h>
extern int check_name_only_capital_letters(char* p);
extern int check_len(char* p);
extern int check_password(char *n,char* p);
extern void input(char* n, char* p);
void run(char* n, char* p) {
	if (check_len(n) && check_len(p)) {
		if (check_name_only_capital_letters(n)) {
			if (check_password(n,p)) {
				puts("Correct");
				return;
			}
		}
	}
	puts("Wrong");
}
int main() {
	char* name, * password;
	name = malloc(200);
	password = malloc(200);
	input(name,password);
	run(name, password);
	system("pause>0");
}