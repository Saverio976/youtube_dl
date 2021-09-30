module youtugo

import time
import os { exists, rm }

fn test_download_audio() {
	path := download_audio('YykjpeuMNEk', '.') or { '' }
	assert path != ''
	assert exists(path) == true
	time.sleep(3*time.second)
	rm(path) or {}
}

fn test_download_video() {
	path := download_video('YykjpeuMNEk', '.') or { '' }
	assert path != ''
	assert exists(path) == true
	rm(path) or {}
}
