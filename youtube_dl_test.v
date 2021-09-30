module youtube_dl

import os { exists, rm }

fn test_download_audio() {
	path := download_audio('https://youtube.com/watch?v=YykjpeuMNEk', '.') or { '' }
	assert path != ''
	assert exists(path) == true
	rm(path) or {}
}

fn test_download_video() {
	path := download_video('https://youtu.be/YykjpeuMNEk', '.') or { '' }
	assert path != ''
	assert exists(path) == true
	rm(path) or {}
}

fn test_download_non_ascii() {
	path := download_audio('https://youtu.be/5zo7BYoaqAA', '.') or { '' }
	assert path != ''
	assert exists(path) == true
	rm(path) or {}
}