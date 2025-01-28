package model

import "time"

type WebResponse[T any] struct {
	Data      T
	Message   string
	Timestamp time.Time
	Paging    *PageMetaData
}

type PageMetaData struct {
	Page      int32 `json:"page"`
	Size      int32 `json:"size"`
	TotalItem int32 `json:"total_item"`
	TotalPage int32 `json:"total_page"`
}
