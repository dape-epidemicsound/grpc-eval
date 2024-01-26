sounds-kotlin:
	protoc sounds.proto --kotlin_out=gen/kotlin --proto_path=/opt/homebrew/Cellar/protobuf/25.2/include/google/protobuf --proto_path=.	

playlists-kotlin:
	protoc playlists.proto --kotlin_out=gen/kotlin --proto_path=/opt/homebrew/Cellar/protobuf/25.2/include/google/protobuf --proto_path=.
