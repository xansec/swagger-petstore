TARGET_NAME='mapi-swagger-petstore'
ORGANIZATION_NAME='forallsecure'

build:
	docker build -t $(TARGET_NAME) .
run: build
	docker run  --name $(TARGET_NAME) -d -p 8080:8080 $(TARGET_NAME)
fuzz:
	mapi run $(ORGANIZATION_NAME)/$(TARGET_NAME) 20 --url "http://localhost:8080" "http://localhost:8080/api/v3/openapi.json" --header "api_key: special-key" 
