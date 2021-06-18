import os { exists, rm }
import youtugo

fn test_download_audio() {
	path := youtugo.download_audio('YykjpeuMNEk', '.') or { '' }
	assert path != ''
	assert exists(path) == true
	rm(path) or {}
}

fn test_download_video() {
	path := youtugo.download_video('YykjpeuMNEk', '.') or { '' }
	assert path != ''
	assert exists(path) == true
	rm(path) or {}
}
