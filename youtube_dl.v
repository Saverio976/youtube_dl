module youtube_dl

import youtugo
import yt_download

import net.http { get_text }

fn parse_video_id(url string) ?string {
	if url.starts_with('https://youtube.com/watch?v=') {
		return url[28..]
	}
	if url.starts_with('https://youtube.com/embed/') {
		return url[26..]
	}
	if url.starts_with('https://youtu.be/') {
		return url[17..]
	}
	eprintln('unable to find video id')
	return none
}

fn is_valid_url(id string) bool {
	text := get_text('https://youtube.com/oembed?format=json&url=https://www.youtube.com/watch?v=$id')
	_ := text.index('{') or {
		eprintln('non-existant video')
		return false
	}
	return true
}

pub fn download_audio(url string, dir string) ?string {
	id := parse_video_id(url) or { return none }
	if !is_valid_url(id) {
		return none
	}
	mut path := youtugo.download_audio(id, dir) or { '' }
	if path != '' {
		return path
	}
	path = yt_download.download_best_audio(id, dir) or { '' }
	if path != '' {
		return path
	}
	eprintln('could not download audio of this link')
	return none
}

pub fn download_video(url string, dir string) ?string {
	id := parse_video_id(url) or { return none }
	if !is_valid_url(id) {
		return none
	}
	mut path := yt_download.download_video(id, dir) or { '' }
	if path != '' {
		return path
	}
	path = youtugo.download_video(id, dir) or { '' }
	if path != '' {
		return path
	}
	eprintln('could not download video of this link')
	return none
}
