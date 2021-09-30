module yt_download

import time
import os { exists, rm }

fn test_download_audio() {
	path := download_best_audio('YykjpeuMNEk', '.') or { 
		println(err.str())
		''
	}
	assert path != ''
	assert exists(path) == true
	time.sleep(3*time.second)
	rm(path) or {}
}

fn test_download_video() {
	path := download_video('YykjpeuMNEk', '.') or { 
		println(err.str())
		''
	}
	assert path != ''
	assert exists(path) == true
	rm(path) or {}
}
