import os { exists, rm }
import youtube_dl.yt_download

fn test_download_audio() {
	path := yt_download.download_best_audio('YykjpeuMNEk', '.') or { 
		println(err.str())
		''
	}
	assert path != ''
	assert exists(path) == true
	rm(path) or {}
}

fn test_download_video() {
	path := yt_download.download_video('YykjpeuMNEk', '.') or { 
		println(err.str())
		''
	}
	assert path != ''
	assert exists(path) == true
	rm(path) or {}
}
