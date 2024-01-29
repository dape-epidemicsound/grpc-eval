package playlists

import (
	"context"
	"net/http"

	epidemic "github.com/epidemicsound/sampled/gen"
)

type service struct {
	epidemic.UnimplementedPlaylistsServiceServer
}

func (s *service) Create(ctx context.Context, r *epidemic.CreatePlaylistRequest) (*epidemic.CreatePlaylistResponse, error) {
	return nil, nil
}

func (s *service) List(ctx context.Context, r *epidemic.ListPlaylistsRequest) (*epidemic.ListPlaylistsResponse, error) {
	return nil, nil
}

func NewService() epidemic.PlaylistsServiceServer {
	return &service{}
}

func HandleList(w http.ResponseWriter, req *http.Request) {
}

func HandleCreate(w http.ResponseWriter, req *http.Request) {
}
