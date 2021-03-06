list:
	@sh -c "$(MAKE) -p no_op__ | \
		awk -F':' '/^[a-zA-Z0-9][^\$$#\/\\t=]*:([^=]|$$)/ {split(\$$1,A,/ /);\
		for(i in A)print A[i]}' | \
		grep -v '__\$$' | \
		grep -v 'make\[1\]' | \
		grep -v 'Makefile' | \
		sort"
# required for list
no_op__:

run:
	echo "Running ansible playbook"
	ansible-playbook -i inventory main.yml
run-arch:
	echo "confirming sudo access"
	sudo true
	echo "Running ansible playbook"
	ansible-playbook -i inventory -e ansible_python_interpreter=`which python2` main.yml
arch-cont-build:
	echo "Build arch linux container"
	docker build --rm=false -t wcollani/arch .

arch-cont-run:
	echo "Test arch container"
	docker run --rm=false -it wcollani/arch
