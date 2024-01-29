package main

import (
	"fmt"
	"net/http"
	"strings"

	epidemic "github.com/epidemicsound/sampled/gen"
	"github.com/epidemicsound/sampled/svc/playlists"
	"github.com/epidemicsound/sampled/svc/sounds"
	"google.golang.org/grpc"
)

func main() {
	s := grpc.NewServer()

	epidemic.RegisterSoundsServiceServer(s, sounds.NewService())
	epidemic.RegisterPlaylistsServiceServer(s, playlists.NewService())

	fmt.Println("hello; sampled", s)

	mux := http.NewServeMux()

	mux.HandleFunc("/status", func(w http.ResponseWriter, req *http.Request) {
		fmt.Fprintf(w, "ok")
	})
	mux.HandleFunc("/sounds", sounds.HandleList)
	mux.HandleFunc("/admin/sounds", sounds.HandleRegister)
	mux.HandleFunc("/sounds/recommended", sounds.HandleListRecommended)
	mux.HandleFunc("/playlists", func(w http.ResponseWriter, req *http.Request) {
		switch req.Method {
		case http.MethodPost:
			playlists.HandleCreate(w, req)

		default:
			playlists.HandleList(w, req)
		}
	})

	http.ListenAndServe(":8080", http.HandlerFunc(func(w http.ResponseWriter, req *http.Request) {
		if req.ProtoMajor == 2 && strings.HasPrefix(
			req.Header.Get("Content-Type"), "application/grpc") {
			s.ServeHTTP(w, req)
		} else {
			mux.ServeHTTP(w, req)
		}
	}))
}
