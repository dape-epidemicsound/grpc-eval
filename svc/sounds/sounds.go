package sounds

import (
	"context"
	"net/http"

	epidemic "github.com/epidemicsound/sampled/gen"
)

type service struct {
	epidemic.UnimplementedSoundsServiceServer
}

func (s *service) List(ctx context.Context, r *epidemic.ListSoundsRequest) (*epidemic.ListSoundsResponse, error) {
	return nil, nil
}

func (s *service) Create(ctx context.Context, r *epidemic.CreateSoundsRequest) (*epidemic.CreateSoundsResponse, error) {
	return nil, nil
}

func (s *service) Recommend(ctx context.Context, r *epidemic.RecommendSoundsRequest) (*epidemic.RecommendSoundsResponse, error) {
	return nil, nil
}

func NewService() epidemic.SoundsServiceServer {
	return &service{}
}

func HandleList(w http.ResponseWriter, req *http.Request) {
}

func HandleRegister(w http.ResponseWriter, req *http.Request) {
}

func HandleListRecommended(w http.ResponseWriter, req *http.Request) {
}
