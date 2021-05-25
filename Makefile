up:
	docker-compose up -d

down:
	docker-compose down

ansible:
	chmod 400 ./keys/id_rsa
	ansible-playbook playbook.yaml -i inventory.ini