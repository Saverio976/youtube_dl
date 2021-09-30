module youtube_dl

import youtugo
import yt_download

// download_audio download the audio (mp3) of the given <url> in the <dir> directory 
pub fn download_audio(url string, dir string) ?string {
	id := parse_video_id(url) or { return err }
	is_valid_url(id) or { return err }
	mut path := yt_download.download_best_audio(id, dir) or { '' }
	if path != '' {
		return path
	}
	path = youtugo.download_audio(id, dir) or { 
		return err
	}
	return path
}

// download_video download the video (mp4) of the given <url> in the <dir> directory 
pub fn download_video(url string, dir string) ?string {
	id := parse_video_id(url) or { return err }
	is_valid_url(id) or { return err }
	mut path := yt_download.download_video(id, dir) or { '' }
	if path != '' {
		return path
	}
	path = youtugo.download_video(id, dir) or { 
		return err
	}
	return path
}
