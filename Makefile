build:
	docker build -t mapi-swagger-petstore .
run: build
	docker run  --name mapi-swagger-petstore -d -p 8080:8080 mapi-swagger-petstore
