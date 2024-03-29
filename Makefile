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

gen/sounds.twirp.go gen/playlists.twirp.go: sounds.proto playlists.proto
	protoc $^ \
		--twirp_out=gen \
		--twirp_opt=paths=source_relative \
		--proto_path=${PWD} \
		--proto_path=/opt/homebrew/Cellar/protobuf/25.2/include/google/protobuf 

bin/cmd/sampled: gen/uuid.pb.go \
		gen/sounds.pb.go \
		gen/sounds_grpc.pb.go \
		gen/playlists.pb.go \
		gen/playlists_grpc.pb.go \
		gen/playlists.twirp.go \
		gen/sounds.twirp.go
	go build -o bin/cmd/sampled ./cmd/sampled/...


clean:
	rm -rf bin/*
	rm -rf gen/*
