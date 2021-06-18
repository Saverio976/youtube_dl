import os { exists, rm }
import youtube_dl

fn test_download_audio() {
	path := youtube_dl.download_audio('https://youtube.com/watch?v=YykjpeuMNEk', '.') or { '' }
	assert path != ''
	assert exists(path) == true
	rm(path) or {}
}

fn test_download_video() {
	path := youtube_dl.download_video('https://youtu.be/YykjpeuMNEk', '.') or { '' }
	assert path != ''
	assert exists(path) == true
	rm(path) or {}
}

fn test_download_non_ascii() {
	path := youtube_dl.download_audio('https://youtu.be/5zo7BYoaqAA', '.') or { '' }
	assert path != ''
	assert exists(path) == true
	rm(path) or {}
}