sounds-kotlin:
	protoc sounds.proto --kotlin_out=gen/kotlin --proto_path=/opt/homebrew/Cellar/protobuf/25.2/include/google/protobuf --proto_path=.	


playlists-kotlin:
	protoc playlists.proto --kotlin_out=gen/kotlin --proto_path=/opt/homebrew/Cellar/protobuf/25.2/include/google/protobuf --proto_path=.


gen/%.pb.go: %.proto
	protoc $< \
		--go_out=gen \
		--go_opt=paths=source_relative \
		--proto_path=${PWD} \
		--proto_path=/opt/homebrew/Cellar/protobuf/25.2/include/google/protobuf


gen/%_grpc.pb.go: %.proto
	protoc $< \
    	--go-grpc_out=gen \
		--go-grpc_opt=paths=source_relative \
		--proto_path=${PWD} \
		--proto_path=/opt/homebrew/Cellar/protobuf/25.2/include/google/protobuf

gen/%.twirp.go: %.proto
	protoc $< \ 
		--twirp_opt=paths=source_relative \
		--twirp_out=gen \
		--proto_path=${PWD} \
		--proto_path=/opt/homebrew/Cellar/protobuf/25.2/include/google/protobuf 

bin/cmd/sampled: gen/uuid.pb.go \
		gen/sounds.pb.go \
		gen/sounds_grpc.pb.go \
		gen/playlists.pb.go \
		gen/playlists_grpc.pb.go
	go build -o bin/cmd/samppled ./cmd/sampled/...


clean:
	rm -rf bin/*
	rm -rf gen/*
