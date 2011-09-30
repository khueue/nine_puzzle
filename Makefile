all:
	swipl -s nine.pl -g "plunit:run_tests" -t halt
